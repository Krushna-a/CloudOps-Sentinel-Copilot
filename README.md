# CloudOps Sentinel Copilot

An intelligent AI copilot designed to streamline cloud operations and incident response by leveraging Self-RAG (Self-Reflective Retrieval-Augmented Generation) techniques. This system helps DevOps teams quickly resolve production issues by intelligently retrieving relevant runbooks, SOPs, and technical documentation.

## 🎯 What Problem Does This Solve?

In fast-paced production environments, engineers often struggle with:

- Finding the right runbook during critical incidents
- Remembering specific troubleshooting steps across multiple services
- Maintaining consistency in incident response procedures
- Onboarding new team members to complex cloud infrastructure

CloudOps Sentinel acts as an intelligent assistant that understands your questions in natural language and retrieves the most relevant troubleshooting information from your internal documentation, complete with verification and quality checks.

## ✨ Key Features

### Self-RAG Architecture

Unlike traditional RAG systems, this implementation includes:

- **Intelligent Retrieval Decision**: Determines whether external documents are needed or if the question can be answered directly
- **Relevance Filtering**: Validates retrieved documents for relevance before using them
- **Answer Verification**: Checks if the generated answer is properly supported by the source documents
- **Usefulness Evaluation**: Ensures the answer actually addresses the user's question
- **Web Search Fallback**: Automatically searches the web when internal docs don't have the answer

### Production-Ready Features

- **FastAPI Backend**: Modern async web framework with automatic API documentation
- **LangGraph State Management**: Sophisticated workflow orchestration with conditional logic
- **Vector Database Integration**: Uses Pinecone for efficient semantic search
- **Conversation Memory**: Maintains context across multiple interactions using SQLite
- **Document Upload**: Easily add new runbooks and documentation through the web interface
- **Audit Trail**: Tracks all queries and responses for compliance and improvement

## 🏗️ Architecture

The system uses a sophisticated multi-step workflow:

```ini
User Question → Retrieval Decision → Retrieve Docs → Relevance Check 
                    ↓                                        ↓
            Generate Direct Answer              Filter & Build Context
                    ↓                                        ↓
                End Process                    Generate Answer → Verify Support
                                                                    ↓
                                                           Check Usefulness
                                                                    ↓
                                                              Final Answer
```

Each step includes validation and can trigger retries or alternative paths (like web search) if quality thresholds aren't met.

## 🛠️ Technology Stack

- **Backend**: FastAPI, Python 3.11+
- **AI Framework**: LangChain, LangGraph
- **LLM**: OpenAI GPT-4
- **Vector Store**: Pinecone
- **Embeddings**: OpenAI text-embedding-3-large
- **Web Search**: Tavily API
- **Database**: SQLite (for audit logs and memory)
- **Frontend**: HTML, CSS, JavaScript (vanilla)

## 📋 Prerequisites

- Python 3.11 or higher
- OpenAI API key
- Pinecone API key
- Tavily API key (for web search)

## 🚀 Getting Started

### 1. Clone and Setup

```bash
cd CloudOps-Sentinel-Copilot
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### 2. Configure Environment Variables

Create a `.env` file in the root directory:

```env
OPENAI_API_KEY=your_openai_api_key_here
PINECONE_API_KEY=your_pinecone_api_key_here
PINECONE_INDEX_NAME=cloudops-sentinel
TAVILY_API_KEY=your_tavily_api_key_here
```

### 3. Initialize the Database

The application will automatically create the SQLite database on first run, but you can also initialize it manually:

```bash
python -c "from src.db import init_db; init_db()"
```

### 4. Ingest Sample Documents

The project includes sample runbooks in the `documents/` folder. To ingest them:

```bash
python data_ingestion.py
```

Or upload them through the web interface once the app is running.

### 5. Run the Application

```bash
uvicorn app:app --reload
```

Visit `http://localhost:8000` in your browser to access the interface.

## 📚 Sample Use Cases

**Scenario 1: API Troubleshooting**

```yaml
User: "The checkout API is returning 500 errors, what should I check?"
System: [Retrieves checkout-api-runbook.md]
Answer: "Start by checking these key areas: 1) Database connections..."
```

**Scenario 2: Deployment Issues**

```md
User: "Need to rollback the payment service deployment"
System: [Retrieves deployment-rollback-sop.md]
Answer: "Follow these steps for a safe rollback: 1) Access the deployment dashboard..."
```

**Scenario 3: Performance Investigation**

```ini
User: "Payment service CPU is spiking to 90%"
System: [Retrieves payments-high-cpu-runbook.md]
Answer: "Here's the systematic approach to diagnose high CPU..."
```

## 🔍 How It Works

### Document Ingestion

1. Documents (PDF, MD, DOCX) are uploaded via the web interface or CLI
2. Text is extracted and split into semantic chunks
3. Chunks are embedded using OpenAI's embedding model
4. Vectors are stored in Pinecone with metadata

### Query Processing

1. User submits a question through the web interface
2. LLM decides if retrieval is needed or can answer directly
3. If retrieval is needed:
   - Query is potentially rewritten for better results
   - Relevant documents are retrieved from Pinecone
   - LLM filters for relevance
   - Context is built from relevant chunks

4. Answer is generated based on context
5. System verifies the answer is supported by sources
6. Usefulness is evaluated
7. If quality checks fail, system may retry or fall back to web search

## 📊 Project Structure

```ini
CloudOps-Sentinel-Copilot/
├── app.py                      # FastAPI application entry point
├── data_ingestion.py          # CLI tool for batch document ingestion
├── src/
│   ├── self_rag.py            # Core Self-RAG logic and LangGraph workflow
│   ├── models.py              # Pydantic models for API requests/responses
│   ├── ingestion.py           # Document processing and vectorization
│   ├── vectorstore.py         # Pinecone vector store management
│   ├── db.py                  # SQLite audit logging
│   └── config.py              # Configuration and settings
├── documents/                  # Sample runbooks and SOPs
├── templates/                  # HTML templates
├── static/                     # CSS and JavaScript
├── uploads/                    # User-uploaded documents
├── data/                       # SQLite databases
└── Self-Rag-Code/             # Jupyter notebooks showing RAG development steps
```

## 🧪 Development Journey

The `Self-Rag-Code/` directory contains Jupyter notebooks that document the step-by-step development of the Self-RAG system:

- `self_rag_step1.ipynb`: Basic retrieval decision logic
- `self_rag_step2.ipynb`: Adding relevance filtering
- `self_rag_step3.ipynb`: Context building and generation
- `self_rag_step4.ipynb`: Answer verification
- `self_rag_step5.ipynb`: Usefulness evaluation
- `self_rag_step6.ipynb`: Query rewriting
- `self_rag_final.ipynb`: Complete workflow integration
- `self_rag_web.ipynb`: Web search integration

These notebooks are great for understanding the iterative development process and testing individual components.

## 🔧 Configuration

Key settings can be adjusted in `src/config.py`:

- **LLM Model**: Change the OpenAI model (default: gpt-4o-mini)
- **Temperature**: Adjust creativity (default: 0 for deterministic)
- **Retrieval Count**: Number of documents to retrieve (default: 4)
- **Chunk Size**: Document chunking parameters
- **Retry Limits**: Max retries for quality checks

## 🎨 API Endpoints

- `GET /` - Web interface
- `POST /api/chat` - Submit a question and get an answer
- `POST /api/upload` - Upload a new document
- `GET /api/health` - Health check
- `GET /api/audits` - View recent audit logs

Interactive API documentation is available at `http://localhost:8000/docs`

## 🔐 Security Considerations

- API keys should be stored in `.env` file (never commit to git)
- The `.env` file is already in `.gitignore`
- User uploads are validated for file type
- SQL injection is prevented through parameterized queries

## 🚧 Future Enhancements

Some ideas for extending this project:

- [ ] Multi-tenant support with namespace isolation
- [ ] Integration with Slack/Teams for incident alerts
- [ ] Advanced analytics dashboard
- [ ] Support for more document formats (HTML, JSON schemas)
- [ ] Fine-tuned embeddings on domain-specific content
- [ ] A/B testing different RAG strategies
