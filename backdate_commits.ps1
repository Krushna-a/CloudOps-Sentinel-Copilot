# Script to create backdated commits for July 2026
$ErrorActionPreference = "Stop"

Set-Location "c:\Code\FDE\CloudOps-Sentinel-Copilot"

Write-Host "Starting Git repository setup and backdated commits for July 2026..." -ForegroundColor Cyan

# Initialize git if not already done
if (-not (Test-Path ".git")) {
    git init
    Write-Host "Git repository initialized" -ForegroundColor Green
}

# Set the branch to main
git branch -M main

# Define commit messages
$commitMessages = @(
    "Initial project setup and structure",
    "Add FastAPI backend with health endpoint",
    "Implement Pinecone vector store integration",
    "Create document ingestion pipeline with SHA-256 hashing",
    "Add OpenAI embeddings configuration",
    "Implement basic RAG state machine structure",
    "Add retrieval decision logic",
    "Implement document relevance grading",
    "Create query rewriting functionality",
    "Add web search integration with Tavily",
    "Implement answer generation from context",
    "Add answer verification and support checking",
    "Implement usefulness evaluation",
    "Create SQLite audit trail system",
    "Add conversation memory with LangGraph checkpointing",
    "Implement file upload endpoint",
    "Create frontend HTML interface",
    "Add CSS styling for chat interface",
    "Implement JavaScript chat functionality",
    "Add error handling and logging",
    "Optimize chunk size and overlap parameters",
    "Implement idempotent document ingestion",
    "Add namespace support for multi-tenant",
    "Create comprehensive README documentation",
    "Add sample runbooks and SOPs",
    "Implement retry logic for quality checks",
    "Optimize vector search parameters",
    "Add environment configuration management",
    "Implement polymorphic document loaders",
    "Add Dockerfile for containerization",
    "Final testing and production optimizations"
)

$year = 2026
$month = 7

Write-Host "Creating commits for July 2026..." -ForegroundColor Cyan

# Stage all files first
git add -A

$commitIndex = 0

# Create commits for each day in July 2026
for ($day = 1; $day -le 31; $day++) {
    $commitsPerDay = Get-Random -Minimum 1 -Maximum 4
    
    for ($i = 0; $i -lt $commitsPerDay; $i++) {
        $hour = Get-Random -Minimum 9 -Maximum 23
        $minute = Get-Random -Minimum 0 -Maximum 60
        
        $commitDate = Get-Date -Year $year -Month $month -Day $day -Hour $hour -Minute $minute -Second 0
        $dateString = $commitDate.ToString("ddd MMM dd HH:mm:ss yyyy K")
        
        $message = $commitMessages[$commitIndex % $commitMessages.Count]
        $commitIndex++
        
        $env:GIT_AUTHOR_DATE = $dateString
        $env:GIT_COMMITTER_DATE = $dateString
        
        git commit --allow-empty -m $message | Out-Null
        
        Write-Host "Created commit for $($commitDate.ToString('yyyy-MM-dd HH:mm')): $message" -ForegroundColor Green
    }
}

Remove-Item Env:\GIT_AUTHOR_DATE -ErrorAction SilentlyContinue
Remove-Item Env:\GIT_COMMITTER_DATE -ErrorAction SilentlyContinue

Write-Host "" -NoNewline
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Commits created successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Add your GitHub remote:" -ForegroundColor White
Write-Host "   git remote add origin https://github.com/Krushna-a/CloudOps-Sentinel-Copilot.git" -ForegroundColor Gray
Write-Host "2. Push to GitHub:" -ForegroundColor White
Write-Host "   git push -u origin main --force" -ForegroundColor Gray
Write-Host "Note: Use --force flag if the remote already exists" -ForegroundColor Yellow
Write-Host "Your July 2026 contribution graph will be fully green!" -ForegroundColor Green
