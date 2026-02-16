# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a simple, two-file CV/Resume system for Diego Barea Gimeno (Backend Engineer) that renders Markdown content dynamically in HTML. It requires no build process, frameworks, or dependencies - just a static HTML file that fetches and renders a Markdown file using Marked.js.

**Key characteristics:**
- **cv.md**: Editable CV content in Markdown format
- **index.html**: Self-contained HTML/CSS/JavaScript renderer
- **No dependencies**: No npm, no build tools, no package.json needed
- **Deployment**: Works with any static hosting (GitHub Pages, Netlify, Vercel, Cloudflare Pages)

## File Structure

```
cv/
├── cv.md           # CV content in Markdown (edit this to update CV)
├── index.html      # HTML/CSS/JavaScript renderer with Marked.js
├── README.md       # Full documentation in Spanish
└── CLAUDE.md       # This file
```

## Common Development Commands

### Running Locally

**IMPORTANT**: Always use a local server for development. Opening `index.html` directly in the browser will fail due to CORS restrictions on the `fetch()` call that loads `cv.md`.

```bash
# Python (recommended)
python3 -m http.server 8000
# Then open http://localhost:8000

# Node.js
npx http-server

# PHP
php -S localhost:8000
```

### Editing the CV

1. Edit `cv.md` with CV content in Markdown
2. Reload browser to see changes
3. No build step required - changes are reflected immediately

### Generating PDF

**Browser method:**
- Click "Descargar PDF" button in top-right corner
- Or use `Cmd+P` / `Ctrl+P` → "Save as PDF"
- Set margins to "Minimum" for best print results
- Chrome/Edge recommended for best PDF quality

### Deploying

**GitHub Pages:**
```bash
git init
git add .
git commit -m "Initial CV"
git branch -M main
git remote add origin <repo-url>
git push -u origin main
# Then enable GitHub Pages in: Settings > Pages > Source: main branch
```

**Other platforms:**
- **Netlify**: Drag & drop the files
- **Vercel**: Auto-deploy from Git repository
- **Cloudflare Pages**: Connect Git repo or upload files

All platforms support custom domains.

## Architecture & Data Flow

### Rendering Pipeline

1. Browser loads `index.html`
2. JavaScript `fetch()` loads `cv.md` from same directory
3. Marked.js library parses Markdown → HTML
4. Post-processing JavaScript performs transformations:
   - **Remove emoji characters** from h2 headings
   - **Detect skills sections**: h2 elements matching `/competencias|skills|habilidades/i` followed by `<ul>` get `.skills-section` class applied
   - **Hide empty sections**: h2 sections with no meaningful content (only `<hr>` or whitespace) are automatically hidden
5. Rendered HTML is injected into `#cv-container` div

### Key Features

**Two-File Deployment:**
- Only 2 files needed: `cv.md` + `index.html`
- No backend, no Node.js, no build process
- Marked.js loaded from CDN: https://cdn.jsdelivr.net/npm/marked/marked.min.js

**Responsive Design:**
- Mobile breakpoint at 768px
- Contact info switches from horizontal to vertical layout on mobile devices
- Skills grid becomes single column on mobile devices
- Fixed "Descargar PDF" button becomes relatively positioned on mobile devices

**Editorial Typography:**
- **Headings**: Playfair Display (serif, high-contrast)
- **Body**: Bricolage Grotesque (sans-serif, clean)
- Fonts loaded from Google Fonts

**Print Optimization:**
- Print-specific CSS removes background colors
- Hides download button
- Adjusts font sizes for PDF output
- Prevents page breaks after headings

## Important Technical Details

### CORS Limitations

**Problem**: Opening `index.html` directly in a browser (file:// protocol) causes `fetch()` to fail with a CORS error when loading `cv.md`.

**Solution**: Always use a local HTTP server during development (see "Running Locally" section above).

### Skills Section Styling

The JavaScript automatically detects "skills" sections by checking h2 text content:

```javascript
// In index.html (line 336-344)
let inSkillsSection = false;
allElements.forEach(el => {
    if (el.tagName === 'H2') {
        inSkillsSection = /competencias|skills|habilidades/i.test(el.textContent);
    }
    if (inSkillsSection && el.tagName === 'UL') {
        el.classList.add('skills-section');
    }
});
```

**Result**: Any `<ul>` element following an h2 containing "competencias", "skills", or "habilidades" receives:
- 2-column grid layout (single column on mobile devices)
- Dash bullets (–) instead of standard bullets (•)
- Custom spacing

### Empty Section Auto-Hide

The JavaScript automatically scans all h2 sections and hides those without meaningful content:

```javascript
// In index.html (line 354-376)
// Logic: If a section only contains <hr> or whitespace between h2 tags, hide it
const hasContent = sectionElements.some(el => {
    if (el.tagName === 'HR') return false;
    const text = el.textContent.trim();
    return text.length > 0;
});

if (!hasContent) {
    elements[h2Idx].style.display = 'none';
    sectionElements.forEach(el => { el.style.display = 'none'; });
}
```

**Example**: The "Certificaciones" section in `cv.md` has only an `<hr>` separator and no content, so it's automatically hidden from view.

### CSS Customization

The design system is controlled by CSS variables in `index.html`:

```css
:root {
    --text-primary: #1a1a1a;      /* Main heading and body text */
    --text-secondary: #525252;     /* Paragraph text, metadata */
    --text-tertiary: #737373;      /* Dates, subtle elements */
    --bg-page: #fafafa;            /* Page background */
    --bg-subtle: #f5f5f5;          /* Card backgrounds (unused in current design) */
    --border-color: #e5e5e5;       /* Separator colors, underlines */
}
```

**Typography:**
- **H1**: 3.2em (desktop), 2.4em (mobile, print)
- **H2**: 1.7em (desktop), 1.5em (mobile), 1.3em (print)
- **Body**: 1em with 1.7 line-height
- **Links**: Underlined with subtle color (`--border-color`); hover state changes to `--text-secondary`

**Spacing Rhythm:**
- Variable spacing between h2 elements to avoid mechanical/perfect spacing: 32px, 48px, 52px, 50px, 54px, 38px
- This creates a more editorial, hand-crafted aesthetic

## Troubleshooting

### "Error al cargar el CV"

**Cause**: Either `cv.md` is missing, or CORS is blocking the fetch.

**Solutions**:
1. Ensure `cv.md` is in the same directory as `index.html`
2. Use a local server instead of opening HTML directly (CORS issue)
3. Check browser console for specific error messages

### PDF Export Issues

**Symptoms**: PDF looks bad, text is cut off, or spacing appears incorrect

**Solutions**:
1. Use Chrome or Edge (best print engine support)
2. Adjust print margins to "Minimum" in print dialog
3. Try the "Descargar PDF" button instead of browser print shortcut
4. Check print preview before saving

### Skills Section Not Formatting Correctly

**Cause**: The h2 heading doesn't contain "competencias", "skills", or "habilidades" (case-insensitive).

**Solution**: Ensure the h2 text matches the regex pattern: `/competencias|skills|habilidades/i`

**Example working h2 values:**
- `## 🛠️ Competencias Técnicas`
- `## Skills`
- `## Habilidades`

## Markdown Syntax Reference

The system uses Marked.js with GitHub-flavored Markdown support:

- `# Title` → H1 (used for name)
- `## Section` → H2 (main sections)
- `### Subsection` → H3 (job titles, education)
- `**bold**` → **bold text**
- `*italic*` → *italic text*
- `[link text](url)` → clickable links
- `- item` → bulleted lists
- `---` → horizontal rule separator

## Development Tips

1. **Version Control**: Keep `cv.md` in a private Git repository for backup
2. **Multiple Versions**: Create branches for different CV versions (e.g., `cv-english`, `cv-tech-focus`)
3. **Testing**: Always test PDF export after making significant CSS changes
4. **Customization**: Modify CSS variables in `index.html` rather than individual selectors
5. **Content Updates**: Only edit `cv.md` - never edit the content directly in `index.html`
