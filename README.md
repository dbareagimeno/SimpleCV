# CV de Diego Barea Gimeno

Sistema de CV profesional que renderiza Markdown dinámicamente en HTML.

## 📁 Estructura

```
cv-diego/
├── cv.md           # Contenido del CV en Markdown (edita aquí)
├── index.html      # Renderizador HTML con estilos
└── README.md       # Este archivo
```

## 🚀 Cómo usar

### Opción 1: Abrir localmente
1. Abre `index.html` directamente en tu navegador
2. El HTML cargará automáticamente `cv.md` y lo renderizará

### Opción 2: Servidor local (recomendado)
```bash
# Con Python
python3 -m http.server 8000

# Con Node.js
npx http-server

# Con PHP
php -S localhost:8000
```
Luego abre: http://localhost:8000

### Opción 3: Deploy online (GitHub Pages)
```bash
git init
git add .
git commit -m "Initial CV"
git branch -M main
git remote add origin <tu-repo>
git push -u origin main
```
Activa GitHub Pages en Settings > Pages > Source: main branch

## ✏️ Editar el CV

**Solo tienes que editar `cv.md`** - los cambios se reflejarán automáticamente al recargar el HTML.

### Sintaxis Markdown compatible:
- `# Título` → H1
- `## Sección` → H2
- `### Subsección` → H3
- `**negrita**` → **negrita**
- `*cursiva*` → *cursiva*
- `[link](url)` → enlaces
- `- lista` → listas con bullets
- `---` → separadores

## 📄 Exportar a PDF

### Método 1: Desde el navegador
1. Abre `index.html`
2. Click en "📄 Descargar PDF" (arriba a la derecha)
3. O usa `Ctrl+P` / `Cmd+P`
4. Selecciona "Guardar como PDF"
5. Ajusta márgenes a "Mínimo" para mejor resultado

### Método 2: Con Puppeteer (automatizado)
```bash
npm install -g puppeteer
```

```javascript
// generate-pdf.js
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('file://' + __dirname + '/index.html', {
    waitUntil: 'networkidle0'
  });
  await page.pdf({
    path: 'Diego_Barea_CV.pdf',
    format: 'A4',
    margin: { top: '20mm', bottom: '20mm', left: '20mm', right: '20mm' }
  });
  await browser.close();
})();
```

```bash
node generate-pdf.js
```

### Método 3: Con pandoc
```bash
pandoc cv.md -o cv.pdf --pdf-engine=xelatex
```

## 🎨 Personalizar estilos

Edita las variables CSS en `index.html`:

```css
:root {
    --primary-color: #2563eb;      /* Color principal */
    --secondary-color: #1e40af;     /* Color secundario */
    --text-primary: #1f2937;        /* Color texto principal */
    --text-secondary: #6b7280;      /* Color texto secundario */
}
```

## 🌐 Dominios sugeridos

Si quieres publicarlo online:
- **GitHub Pages:** `tu-usuario.github.io/cv`
- **Netlify:** Drag & drop gratuito
- **Vercel:** Deploy automático con Git
- **Cloudflare Pages:** Rápido y gratuito

## 🔧 Ventajas de este sistema

✅ **Un solo lugar para editar** - todo el contenido en `cv.md`
✅ **Control total del diseño** - CSS personalizable
✅ **Responsive** - se adapta a móvil y tablet
✅ **Print-friendly** - exporta perfecto a PDF
✅ **Versionable** - usa Git para trackear cambios
✅ **Portable** - comparte solo 2 archivos
✅ **SEO-friendly** - si lo hosteas online

## 📝 Tips

1. **Backup**: Guarda `cv.md` en un repositorio privado
2. **Versiones**: Crea ramas para versiones específicas (ej: `cv-english`)
3. **Analytics**: Si lo hosteas, añade Google Analytics
4. **Dominio personalizado**: Usa `tucv.com` en Netlify/GitHub Pages
5. **Dark mode**: Añade `prefers-color-scheme` en CSS

## 🐛 Troubleshooting

**"Error al cargar el CV"**
- Asegúrate de que `cv.md` está en el mismo directorio que `index.html`
- Si abres `index.html` directamente, algunos navegadores bloquean `fetch()` por CORS
- Solución: usa un servidor local (Opción 2)

**"El PDF se ve mal"**
- Usa Chrome/Edge para mejor resultado
- Ajusta márgenes en opciones de impresión
- Prueba la herramienta de "Descargar PDF" del botón superior

## 📧 Contacto

Diego Barea Gimeno  
dbarea2303@gmail.com  
[LinkedIn](https://www.linkedin.com/in/diego-bareagimeno-772323248)
