/**
 * Timeline Bíblica Interativa
 * Projeto: Portal Promessas de Jesus
 * Autor: Vancouver Tech
 */

class BiblicalTimeline {
    constructor(containerId) {
        this.container = document.getElementById(containerId);
        this.currentTestament = 'old';
        this.data = {
            old: null,
            new: null,
            config: null
        };
        this.isLoading = false;
        
        this.init();
    }
    
    async init() {
        try {
            await this.loadData();
            this.render();
            this.bindEvents();
            console.log('✅ Timeline Bíblica carregada com sucesso');
        } catch (error) {
            console.error('❌ Erro ao carregar timeline:', error);
            this.showError('Erro ao carregar a linha do tempo bíblica');
        }
    }
    
    async loadData() {
        this.isLoading = true;
        this.showLoading();
        
        try {
            // Carregar configurações
            const configResponse = await fetch('json/timeline/timeline-config.json');
            this.data.config = await configResponse.json();
            
            // Carregar Antigo Testamento
            const otResponse = await fetch('json/timeline/old-testament.json');
            this.data.old = await otResponse.json();
            
            // Carregar Novo Testamento
            const ntResponse = await fetch('json/timeline/new-testament.json');
            this.data.new = await ntResponse.json();
            
        } catch (error) {
            throw new Error('Falha ao carregar dados: ' + error.message);
        } finally {
            this.isLoading = false;
            this.hideLoading();
        }
    }
    
    render() {
        if (!this.container || !this.data.config) return;
        
        this.container.innerHTML = `
            <div class="timeline-header">
                <h1 class="timeline-title">${this.data.config.metadata.title}</h1>
                <p class="timeline-description">${this.data.config.metadata.description}</p>
                
                <div class="testament-selector">
                    <button class="testament-btn ${this.currentTestament === 'old' ? 'active' : ''}" 
                            data-testament="old">
                        📜 Antigo Testamento
                    </button>
                    <button class="testament-btn ${this.currentTestament === 'new' ? 'active' : ''}" 
                            data-testament="new">
                        ✝️ Novo Testamento
                    </button>
                </div>
            </div>
            
            <div class="timeline-container">
                <div class="timeline-line"></div>
                ${this.renderTestament()}
            </div>
            
            <div class="timeline-stats">
                📊 Total: ${this.data.config.metadata.totalBooks} livros | 
                📜 AT: ${this.data.config.metadata.oldTestamentBooks} | 
                ✝️ NT: ${this.data.config.metadata.newTestamentBooks} |
                📚 Manuscritos: ${this.data.config.metadata.manuscripts}
            </div>
        `;
    }
    
    renderTestament() {
        const testament = this.data[this.currentTestament];
        if (!testament || !testament.keyBooks) return '<p>Dados não disponíveis</p>';
        
        return `
            <div class="testament-section" data-testament="${this.currentTestament}">
                <div class="testament-header">
                    <h2 class="testament-title-main">${testament.title}</h2>
                    <p class="testament-subtitle">${testament.subtitle}</p>
                    <div class="testament-period">${testament.period}</div>
                </div>
                
                <div class="books-timeline">
                    ${testament.keyBooks.map(book => this.renderBook(book)).join('')}
                </div>
            </div>
        `;
    }
    
    renderBook(book) {
        const isEven = book.order % 2 === 0;
        
        return `
            <div class="bible-book ${isEven ? 'even' : 'odd'}" data-book="${book.id}">
                <div class="timeline-marker" 
                     style="background-color: ${book.timeline.color}"
                     data-period="${book.timeline.start}-${book.timeline.end}">
                </div>
                
                <div class="book-content">
                    <div class="book-header">
                        <h3 class="book-name">${book.name}</h3>
                        <div class="book-meta">
                            <span class="book-order">Livro ${book.order}</span>
                            <span class="book-period">${book.period}</span>
                            <span class="book-author">por ${book.author}</span>
                        </div>
                    </div>
                    
                    <div class="book-theme">
                        <strong>Tema:</strong> ${book.theme}
                    </div>
                    
                    <div class="book-key-verse">
                        <strong>${book.keyVerse.reference}:</strong>
                        <em>"${book.keyVerse.text}"</em>
                    </div>
                    
                    <div class="book-summary">
                        ${book.summary}
                    </div>
                    
                    <div class="book-events">
                        <h4>🔥 Fatos Marcantes:</h4>
                        ${book.keyEvents.map(event => this.renderEvent(event)).join('')}
                    </div>
                    
                    <button class="btn-expand" data-book="${book.id}">
                        Ver Mais Detalhes 📖
                    </button>
                </div>
            </div>
        `;
    }
    
    renderEvent(event) {
        return `
            <div class="timeline-event" data-event="${event.id}">
                <div class="event-header">
                    <h5 class="event-title">${event.title}</h5>
                    <span class="event-verse">${event.verse}</span>
                </div>
                
                <p class="event-description">${event.description}</p>
                <p class="event-significance"><strong>Significado:</strong> ${event.significance}</p>
                
                ${event.archaeological ? `
                    <div class="archaeological-evidence">
                        <h6>🏺 Evidência Arqueológica:</h6>
                        <div class="evidence-content">
                            <div class="evidence-image">
                                <img src="assets/images/timeline/archaeological/${event.archaeological.image}" 
                                     alt="${event.title} - Evidência Arqueológica"
                                     loading="lazy"
                                     onerror="this.style.display='none'">
                            </div>
                            <div class="evidence-text">
                                <p><strong>Descoberta:</strong> ${event.archaeological.evidence}</p>
                                <p>${event.archaeological.description}</p>
                                <div class="evidence-sources">
                                    <strong>Fontes:</strong> ${event.archaeological.sources.join(', ')}
                                </div>
                            </div>
                        </div>
                    </div>
                ` : ''}
                
                ${event.coordinates ? `
                    <div class="location-info">
                        📍 <strong>Local:</strong> ${event.coordinates.label}
                        <button class="btn-map" data-lat="${event.coordinates.lat}" 
                                data-lng="${event.coordinates.lng}" data-label="${event.coordinates.label}">
                            Ver no Mapa 🗺️
                        </button>
                    </div>
                ` : ''}
            </div>
        `;
    }
    
    bindEvents() {
        // Seletor de testamento
        this.container.addEventListener('click', (e) => {
            if (e.target.classList.contains('testament-btn')) {
                const testament = e.target.dataset.testament;
                this.switchTestament(testament);
            }
            
            // Botão expandir livro
            if (e.target.classList.contains('btn-expand')) {
                const bookId = e.target.dataset.book;
                this.expandBook(bookId);
            }
            
            // Botão mapa
            if (e.target.classList.contains('btn-map')) {
                const lat = parseFloat(e.target.dataset.lat);
                const lng = parseFloat(e.target.dataset.lng);
                const label = e.target.dataset.label;
                this.showMap(lat, lng, label);
            }
            
            // Marcador da timeline
            if (e.target.classList.contains('timeline-marker')) {
                const period = e.target.dataset.period;
                this.showPeriodInfo(period);
            }
        });
        
        // Animações de scroll
        if ('IntersectionObserver' in window) {
            this.setupScrollAnimations();
        }
    }
    
    switchTestament(testament) {
        if (testament === this.currentTestament) return;
        
        this.currentTestament = testament;
        
        // Update active button
        this.container.querySelectorAll('.testament-btn').forEach(btn => {
            btn.classList.remove('active');
        });
        this.container.querySelector(`[data-testament="${testament}"]`).classList.add('active');
        
        // Re-render timeline
        const timelineContainer = this.container.querySelector('.timeline-container');
        timelineContainer.innerHTML = `
            <div class="timeline-line"></div>
            ${this.renderTestament()}
        `;
        
        // Scroll animation
        timelineContainer.style.opacity = '0';
        timelineContainer.style.transform = 'translateY(20px)';
        
        setTimeout(() => {
            timelineContainer.style.transition = 'all 0.5s ease';
            timelineContainer.style.opacity = '1';
            timelineContainer.style.transform = 'translateY(0)';
        }, 100);
    }
    
    setupScrollAnimations() {
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-in');
                }
            });
        }, { threshold: 0.1 });
        
        // Observe all book elements
        setTimeout(() => {
            this.container.querySelectorAll('.bible-book').forEach(book => {
                observer.observe(book);
            });
        }, 500);
    }
    
    expandBook(bookId) {
        const bookElement = this.container.querySelector(`[data-book="${bookId}"]`);
        const button = bookElement.querySelector('.btn-expand');
        
        bookElement.classList.toggle('expanded');
        button.textContent = bookElement.classList.contains('expanded') 
            ? 'Recolher 📖' 
            : 'Ver Mais Detalhes 📖';
    }
    
    showMap(lat, lng, label) {
        // Implementar modal com mapa (Google Maps ou OpenStreetMap)
        alert(`🗺️ Mapa: ${label}\nCoordenadas: ${lat}, ${lng}\n\n(Implementar modal com mapa)`);
    }
    
    showPeriodInfo(period) {
        alert(`📅 Período: ${period}\n\n(Implementar modal com informações do período)`);
    }
    
    showLoading() {
        if (this.container) {
            this.container.innerHTML = `
                <div class="timeline-loading">
                    <div class="loading-spinner"></div>
                    <p>Carregando linha do tempo bíblica...</p>
                </div>
            `;
        }
    }
    
    hideLoading() {
        const loading = this.container?.querySelector('.timeline-loading');
        if (loading) {
            loading.remove();
        }
    }
    
    showError(message) {
        if (this.container) {
            this.container.innerHTML = `
                <div class="timeline-error">
                    <h3>❌ Erro</h3>
                    <p>${message}</p>
                    <button onclick="location.reload()">Tentar Novamente</button>
                </div>
            `;
        }
    }
}

// Inicializar quando DOM estiver pronto
document.addEventListener('DOMContentLoaded', () => {
    if (document.getElementById('biblical-timeline')) {
        window.biblicalTimeline = new BiblicalTimeline('biblical-timeline');
    }
});

// Exportar para uso global
window.BiblicalTimeline = BiblicalTimeline;
