# Tools Configuration

## Required Tools

### Vizcom MCP
Used for all industrial design and rendering work. The agent uses Vizcom to:
- Create product concept renders
- Refine selected designs
- Generate final production renders
- Export images for manufacturer communication and marketing

Vizcom tools: `list_teams`, `create_workbench`, `create_drawing`, `modify_image`, `render_sketch`, `list_styles`, `get_generation_status`, `export_image`, `get_drawing_image`, `accept_result`

### Web Search
Used for market research, finding manufacturers, checking component prices, and general research.

### Email
Used to contact manufacturers, send RFQs with renders and specs, negotiate pricing, and manage production communication.

### File System
Used to read/write state files, save renders, and manage project documentation.

## Tool Policies

- **Web search**: Always allowed (needed for research)
- **File read/write**: Always allowed within the workspace
- **Email send**: Require approval before first send to each new recipient
- **Vizcom renders**: Always allowed (needed for design)
- **Shell commands**: Require approval for anything outside the workspace

## Render Budget

The agent should track render usage:
- Explore phase: up to 12 renders
- Refine phase: up to 30 renders (across top 3 designs)
- Final phase: up to 20 renders
- Total budget: ~60-100 renders max across all phases
