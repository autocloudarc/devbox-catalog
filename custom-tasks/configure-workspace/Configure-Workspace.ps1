param(
    [string]$WorkspacePath = "C:\Workspaces",
    [string]$ProjectName = "default-project"
)

Write-Host "Configuring workspace for project: $ProjectName"

# Set environment variables
[Environment]::SetEnvironmentVariable("WORKSPACE_ROOT", $WorkspacePath, "User")
[Environment]::SetEnvironmentVariable("PROJECT_NAME", $ProjectName, "User")
[Environment]::SetEnvironmentVariable("DEVBOX_INITIALIZED", "true", "User")

# Create project directory
$projectPath = Join-Path -Path $WorkspacePath -ChildPath $ProjectName
New-Item -ItemType Directory -Path $projectPath -Force | Out-Null

Write-Host "Environment variables set:"
Write-Host "  WORKSPACE_ROOT = $WorkspacePath"
Write-Host "  PROJECT_NAME = $ProjectName"
Write-Host "  DEVBOX_INITIALIZED = true"
Write-Host "Project directory created at: $projectPath"
Write-Host "Workspace configuration complete!"
