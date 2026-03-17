# export-solution.ps1
param(
    [string]$OutputFile = "solution_export_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
)

$includeExtensions = @(
    "*.cs", "*.razor", "*.cshtml",
    "*.csproj", "*.sln", "*.slnx",
    "*.json", "*.config", "*.xml", "*.jsonl",
    "*.ps1", "*.md", "*.yaml", "*.yml", "*.sh",
    "*.props", "*.targets", "*.editorconfig", "*.example"
)
$excludeDirs = @("bin", "obj", ".vs", ".git", "node_modules", "packages")
$excludeFiles = @("solution_export_*.txt")

$output = @()
$output += "=== SOLUTION EXPORT ==="
$output += "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$output += "Root: $PWD"
$output += "`n=== DIRECTORY STRUCTURE ===`n"

# All directories including empty
Get-ChildItem -Recurse -Directory | Where-Object {
    $dir = $_
    -not ($excludeDirs | Where-Object { $dir.FullName -like "*\$_\*" -or $dir.Name -eq $_ })
} | Sort-Object FullName | ForEach-Object {
    $relativePath = $_.FullName.Substring($PWD.Path.Length + 1)
    $depth = ($relativePath -split '\\').Count - 1
    $isEmpty = (Get-ChildItem $_.FullName -File -Recurse | Measure-Object).Count -eq 0
    $marker = if ($isEmpty) { "[DIR-EMPTY]" } else { "[DIR]" }
    $output += ("  " * $depth) + "$marker $($_.Name)"
}

$output += "`n=== FILES ===`n"

# Collect matching files
Get-ChildItem -Recurse -Include $includeExtensions | Where-Object {
    $file = $_
    $excluded = $false
    
    # Check excluded directories
    foreach ($exDir in $excludeDirs) {
        if ($file.FullName -like "*\$exDir\*" -or $file.Directory.Name -eq $exDir) {
            $excluded = $true
            break
        }
    }
    
    # Check excluded file patterns
    foreach ($exFile in $excludeFiles) {
        if ($file.Name -like $exFile) {
            $excluded = $true
            break
        }
    }
    
    -not $excluded
} | Sort-Object FullName | ForEach-Object {
    $relativePath = $_.FullName.Substring($PWD.Path.Length + 1)
    $output += "`n`n========================================`n"
    $output += "FILE: $relativePath`n"
    $output += "SIZE: $($_.Length) bytes`n"
    $output += "MODIFIED: $($_.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss'))`n"
    $output += "========================================`n"
    $output += Get-Content $_.FullName -Raw
}

$output | Out-File -FilePath $OutputFile -Encoding UTF8
Write-Host "Exported to: $OutputFile"
Write-Host "File count: $(($output | Select-String -Pattern '^FILE:').Matches.Count)"