/**
 * Module Payload — gestion multi-prêts.
 *
 * Chaque clic sur « Ajouter un prêt » clone le modèle de formulaire prêt
 * (identification + détails, correspondant à la base/type sélectionnés) et
 * lui adjoint des tableaux d'échéances / capitaux vides et éditables, dans
 * une nouvelle section « Informations prêt n°N ». Chaque ligne ajoutée dans
 * ces tableaux reste un formulaire éditable (inputs réels dans les cellules),
 * pas une simple ligne de texte figée.
 *
 * Il n'y a pas de modèle de données JS séparé : à la construction du
 * payload, on lit directement les valeurs dans le DOM (comme pour le reste
 * du formulaire).
 */
const SybrisPayload = {

    counters: {
        pret: 0,
        echeance: 0,
        capital: 0
    },

    /** Templates bruts (HTML) des lignes échéance / capital (un seul, plus de découpage par base). */
    templates: {},

    /** Template brut (HTML) unique du formulaire prêt (plus de découpage par base + type). */
    pretTemplateHtml: '',

    /** [{id}] — un par section "Informations prêt n°N" affichée, dans l'ordre. */
    prets: [],

    /**
     * Dernier type de payload construit ('dossier' | 'entete' | 'final').
     * Permet à addToFlux() de savoir quelle zone du formulaire réinitialiser
     * après ajout au flux, sans toucher aux deux autres.
     */
    lastKind: null,

    init() {
        this._storeTemplates();
        this._storePretTemplates();
        this.prets = [];
        this.counters.pret = 0;
        this.counters.echeance = 0;
        this.counters.capital = 0;
        this.lastKind = null;
        this._renderEmptyPretsContainer();
    },

    _storeTemplates() {
        ['echeance', 'capital'].forEach(type => {
            const el = document.getElementById(`template-${type}`);
            if (el) {
                this.templates[type] = el.innerHTML;
            }
        });
    },

    _storePretTemplates() {
        const el = document.getElementById('pret-template-unifie');
        this.pretTemplateHtml = el ? el.innerHTML : '';
    },

    _getTemplate(type) {
        return this.templates[type];
    },

    _getPretTemplate() {
        return this.pretTemplateHtml;
    },

    getBase() {
        return document.getElementById('selectedBase')?.value || '';
    },

    getTypeDossier() {
        return document.getElementById('selectedTypeDonnee')?.value || '';
    },

    // ============ PRÊTS (clonage visuel du formulaire) ============

    _renderEmptyPretsContainer() {
        const container = document.getElementById('prets-container');
        if (container) {
            container.innerHTML = '<p class="empty-flux-message" id="prets-empty-message">'
                + 'Aucun prêt ajouté. Cliquez sur « Ajouter un prêt ».</p>';
        }
        const countEl = document.getElementById('prets-count');
        if (countEl) countEl.textContent = '0';
    },

    addPret() {
        const base = this.getBase();
        const typeDossier = this.getTypeDossier();

        if (!base || !typeDossier) {
            alert('Sélectionnez une base et un type de dossier avant d\'ajouter un prêt.');
            return;
        }

        const templateHtml = this._getPretTemplate();
        if (!templateHtml) {
            alert('Modèle de prêt introuvable pour cette base/type.');
            return;
        }

        const container = document.getElementById('prets-container');
        if (!container) return;

        const pretId = ++this.counters.pret;
        const suffix = `pret${pretId}`;

        const echeanceSection = this._buildSubItemsSection('echeance', pretId);
        const capitalSection = typeDossier === 'DECLARATION' ? this._buildSubItemsSection('capital', pretId) : '';

        const wrapper = document.createElement('div');
        wrapper.className = 'pret-instance collapsible-section';
        wrapper.dataset.pretId = String(pretId);
        wrapper.innerHTML = `
            <div class="collapsible-header" onclick="toggleSection('pret-instance-${pretId}')">
                <h4>
                    <span class="collapse-icon">▼</span>
                    <span class="pret-instance-title">Informations prêt n°${this.prets.length + 1}</span>
                </h4>
                <button type="button" class="btn btn-danger btn-xs" onclick="event.stopPropagation(); removePret(${pretId});">
                    Supprimer ce prêt
                </button>
            </div>
            <div class="collapsible-content" id="pret-instance-${pretId}">
                ${this._suffixIds(templateHtml, suffix)}
                ${echeanceSection}
                ${capitalSection}
            </div>`;

        container.appendChild(wrapper);

        // Le clone contient TOUS les champs tagués bases/types (comme
        // dossier.jsp) : on applique une fois la visibilité pour la
        // base/le type courants (pas besoin de la garder "live" ensuite,
        // changer de base/type vide tous les prêts via clearPrets()).
        if (window.SybrisUI && typeof window.SybrisUI.refreshFieldVisibilityWithin === 'function') {
            window.SybrisUI.refreshFieldVisibilityWithin(wrapper);
        }

        this.prets.push({ id: pretId });

        const emptyMsg = document.getElementById('prets-empty-message');
        if (emptyMsg) emptyMsg.remove();

        this._renumberPrets();

        if (window.SybrisUI && typeof window.SybrisUI.updateRiskConstraints === 'function') {
            window.SybrisUI.updateRiskConstraints();
        }
        if (window.SybrisUI && typeof window.SybrisUI.refreshConditionalStars === 'function') {
            window.SybrisUI.refreshConditionalStars();
        }
    },

    removePret(pretId) {
        const el = document.querySelector(`.pret-instance[data-pret-id="${pretId}"]`);
        if (el) el.remove();

        this.prets = this.prets.filter(p => p.id !== Number(pretId));

        if (this.prets.length === 0) {
            this._renderEmptyPretsContainer();
        } else {
            this._renumberPrets();
        }
    },

    clearPrets() {
        this.prets = [];
        this.counters.pret = 0;
        this.counters.echeance = 0;
        this.counters.capital = 0;
        this._renderEmptyPretsContainer();
    },

    _renumberPrets() {
        const items = document.querySelectorAll('#prets-container .pret-instance');
        items.forEach((el, idx) => {
            const title = el.querySelector('.pret-instance-title');
            if (title) title.textContent = `Informations prêt n°${idx + 1}`;
        });

        const countEl = document.getElementById('prets-count');
        if (countEl) countEl.textContent = String(items.length);
    },

    // ============ ÉCHÉANCES / CAPITAUX (tableau éditable par prêt) ============

    /**
     * Construit la section repliable "Saisie des échéances/capitaux" d'un
     * prêt : un tableau vide (une ligne = un enregistrement échéance/capital,
     * dont chaque cellule reste un input éditable) et un bouton "+" pour
     * ajouter une ligne.
     */
    _buildSubItemsSection(type, pretId) {
        const templateHtml = this._getTemplate(type);
        if (!templateHtml) return '';

        const fields = this._extractFieldElements(templateHtml);
        const title = type === 'echeance' ? 'Saisie des échéances' : 'Saisie des capitaux';
        const emptyText = type === 'echeance' ? 'Aucune échéance ajoutée' : 'Aucun capital ajouté';
        const addLabel = type === 'echeance' ? 'Ajouter une échéance' : 'Ajouter un capital';
        const headerHtml = `<tr><th>N°</th>${fields.labels.map(l => `<th>${this._escapeHtml(l)}</th>`).join('')}<th></th></tr>`;
        const sectionId = `pret-${pretId}-${type}-section`;

        // display:none par défaut : ce bloc ne devient visible que si
        // updateRiskConstraints() le révèle explicitement (risque correspondant
        // dans RISK_RULES). Avant ce fix, echeance ET capital apparaissaient
        // tous les deux visibles tant que ce calcul n'avait pas encore tourné.
        return `<div class="collapsible-section pret-subitems-block" data-subtype="${type}" id="${sectionId}" style="display:none">
            <div class="collapsible-header" onclick="toggleSection('${sectionId}')">
                <h5><span class="collapse-icon">▼</span> ${title}</h5>
            </div>
            <div class="collapsible-content">
                <div class="items-table-wrapper">
                    <table class="items-table">
                        <thead>${headerHtml}</thead>
                        <tbody id="pret-${pretId}-${type}-tbody">
                            <tr class="items-table-empty-row" data-empty-row="true">
                                <td colspan="${fields.labels.length + 2}">${emptyText}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <button type="button" class="add-item-btn add-row-btn"
                        title="${addLabel}" onclick="addSubItemRow('${type}', ${pretId})">
                    <span>+</span>
                </button>
            </div>
        </div>`;
    },

    /** Ajoute une nouvelle ligne éditable (échéance ou capital) dans le tableau du prêt donné. */
    addSubItemRow(type, pretId) {
        const tbody = document.getElementById(`pret-${pretId}-${type}-tbody`);
        if (!tbody) return;

        const templateHtml = this._getTemplate(type);
        if (!templateHtml) return;
        const fields = this._extractFieldElements(templateHtml);

        const rowId = ++this.counters[type];
        const suffix = `pret${pretId}-${type}-row${rowId}`;

        const visibleCells = fields.visible
            .map(field => `<td>${this._suffixIds(field, suffix)}</td>`)
            .join('');
        const hiddenInputs = fields.hidden
            .map(field => this._suffixIds(field, suffix))
            .join('');

        const emptyRow = tbody.querySelector('[data-empty-row]');
        if (emptyRow) emptyRow.remove();

        const tr = document.createElement('tr');
        tr.dataset.rowId = String(rowId);
        tr.innerHTML = `<td class="row-number"></td>${visibleCells}`
            + `<td class="items-table-hidden-cell" style="display:none">${hiddenInputs}</td>`
            + `<td class="items-table-actions-col">`
            + `<button type="button" class="remove-item-btn" title="Supprimer" `
            + `onclick="removeSubItemRow('${type}', ${pretId}, ${rowId})">✕</button></td>`;
        tbody.appendChild(tr);
        this._renumberRows(tbody);
    },

    removeSubItemRow(type, pretId, rowId) {
        const tbody = document.getElementById(`pret-${pretId}-${type}-tbody`);
        if (!tbody) return;

        const row = tbody.querySelector(`tr[data-row-id="${rowId}"]`);
        if (row) row.remove();

        if (!tbody.querySelector('tr[data-row-id]')) {
            const table = tbody.closest('table');
            const colCount = table ? table.querySelectorAll('thead th').length : 1;
            const emptyText = type === 'echeance' ? 'Aucune échéance ajoutée' : 'Aucun capital ajouté';
            tbody.innerHTML = `<tr class="items-table-empty-row" data-empty-row="true">`
                + `<td colspan="${colCount}">${emptyText}</td></tr>`;
        } else {
            this._renumberRows(tbody);
        }
    },

    _renumberRows(tbody) {
        tbody.querySelectorAll('tr[data-row-id]').forEach((row, idx) => {
            const cell = row.querySelector('.row-number');
            if (cell) cell.textContent = String(idx + 1);
        });
    },

    /** Vide tous les tableaux d'échéances/capitaux de tous les prêts (ex : changement de risque). */
    clearItems(type) {
        document.querySelectorAll(`#prets-container .pret-subitems-block[data-subtype="${type}"] tbody`)
            .forEach(tbody => {
                const table = tbody.closest('table');
                const colCount = table ? table.querySelectorAll('thead th').length : 1;
                const emptyText = type === 'echeance' ? 'Aucune échéance ajoutée' : 'Aucun capital ajouté';
                tbody.innerHTML = `<tr class="items-table-empty-row" data-empty-row="true">`
                    + `<td colspan="${colCount}">${emptyText}</td></tr>`;
            });
    },

    // ============ CONSTRUCTION DU PAYLOAD ============

    build() {
        this.lastKind = 'dossier';

        const base = this.getBase();
        const typeDossier = this.getTypeDossier();

        const prets = this._buildPretsPayloadFromDom(typeDossier);
        const payload = {
            base,
            typeDeclaration: typeDossier,
            ...this._readFields(document.getElementById('shared-fields'), base, typeDossier),
            ...this._readFields(document.getElementById('dossier-form'), base, typeDossier),
            prets,
            formId: 'dossier-form'
        };

        // Compatibilité backend : conserve les champs plats du 1er prêt.
        if (prets.length > 0) {
            const firstPret = { ...prets[0] };
            delete firstPret.echeances;
            delete firstPret.capitaux;
            delete firstPret.pretSelection;
            Object.assign(payload, firstPret);
            payload.echeances = prets[0].echeances || [];
            payload.capitaux = typeDossier === 'DECLARATION' ? (prets[0].capitaux || []) : [];
        } else {
            payload.echeances = [];
            payload.capitaux = [];
        }

        return payload;
    },

    /**
     * Construit le payload de l'enregistrement En-tête (type 01) à partir de
     * #enteteForm. Un seul .base-block actif à la fois selon la base
     * sélectionnée (A a son propre template enTeteA.jsp, B/C partagent enTete.jsp).
     */
    buildEntete() {
        this.lastKind = 'entete';

        const base = this.getBase();
        const root = document.getElementById('enteteForm');
        if (!root) return null;

        return {
            base,
            formId: 'enteteForm',
            ...this._readFields(document.getElementById('shared-fields'), base, null),
            ...this._readFields(root, base, null)
        };
    },

    /**
     * Construit le payload de l'enregistrement Final (type 09) à partir de
     * #final-form. Formulaire commun aux 3 bases (pas de .base-block),
     * c'est le backend qui applique le format propre à chaque base.
     */
    buildFinal() {
        this.lastKind = 'final';

        const base = this.getBase();
        const root = document.getElementById('final-form');
        if (!root) return null;

        return {
            base,
            formId: 'final-form',
            ...this._readFields(document.getElementById('shared-fields'), base, null),
            ...this._readFields(root, base, null)
        };
    },

    _buildPretsPayloadFromDom(typeDossier) {
        const instances = document.querySelectorAll('#prets-container .pret-instance');
        return Array.from(instances).map((instanceEl, idx) => {
            const pretData = this._readPretInstanceFields(instanceEl);
            const echeances = this._readSubItemRows(instanceEl, 'echeance');
            const capitaux = typeDossier === 'DECLARATION' ? this._readSubItemRows(instanceEl, 'capital') : [];
            return {
                ...pretData,
                pretSelection: String(idx + 1),
                echeances,
                capitaux
            };
        });
    },

    /** Lit les champs propres au prêt (hors tableaux échéances/capitaux) d'une instance. */
    _readPretInstanceFields(instanceEl) {
        const base = this.getBase();
        const typeDossier = this.getTypeDossier();
        const data = {};
        instanceEl.querySelectorAll('input, select, textarea').forEach(input => {
            if (!input.name) return;
            if (input.closest('.pret-subitems-block')) return;
            const tagged = input.closest('[data-bases], [data-types]');
            if (tagged && (tagged.dataset.bases || tagged.dataset.types)) {
                const basesAttr = (tagged.dataset.bases || '').trim();
                const typesAttr = (tagged.dataset.types || '').trim();
                const basesOk = !basesAttr || basesAttr.split(/\s+/).includes(base);
                const typesOk = !typesAttr || typesAttr.split(/\s+/).includes(typeDossier);
                if (!basesOk || !typesOk) return; // champ d'une autre base/type : ignoré
            }
            const value = this._readInputValue(input);
            if (value !== undefined) data[input.name] = value;
        });
        return data;
    },

    /** Lit toutes les lignes éditables (échéance ou capital) d'une instance de prêt. */
    _readSubItemRows(instanceEl, type) {
        const rows = instanceEl.querySelectorAll(
            `.pret-subitems-block[data-subtype="${type}"] tbody tr[data-row-id]`);

        return Array.from(rows).map(row => {
            const data = {};
            row.querySelectorAll('input, select, textarea').forEach(input => {
                if (!input.name || input.name.endsWith('Zero')) return; // champ UI uniquement
                const value = this._readInputValue(input);
                if (value !== undefined) data[input.name] = value;
            });
            return data;
        });
    },

    _readInputValue(input) {
        if (input.type === 'checkbox') return input.checked;
        if (input.type === 'radio') return input.checked ? input.value : undefined;
        return input.value;
    },

    _readFields(root, base, typeDossier) {
        const data = {};
        if (!root) return data;

        root.querySelectorAll('input, select, textarea').forEach(input => {
            if (!input.name) return;
            if (!this._isActive(input, base, typeDossier)) return;
            if (!this._isOptionalSectionIncluded(input)) return;
            if (input.closest('#templates, #pret-templates, #prets-container')) return;

            const key = input.name.split('.').pop();
            const value = this._readInputValue(input);

            if (value === undefined) return;
            if (Object.prototype.hasOwnProperty.call(data, key)
                && typeof value === 'string'
                && value.trim() === '') {
                return;
            }
            data[key] = value;
        });

        return data;
    },

    _isOptionalSectionIncluded(input) {
        const optionalSection = input.closest('.optional-section');
        if (!optionalSection) return true;

        const includeCheckbox = optionalSection.querySelector('.include-checkbox input[type="checkbox"]');
        return includeCheckbox ? includeCheckbox.checked : true;
    },

    /**
     * Deux systèmes de scoping base/type coexistent désormais :
     * - NOUVEAU (dossier.jsp/adresse.jsp/detail.jsp) : chaque champ est
     *   individuellement tagué data-bases/data-types (posés par
     *   field-text.jsp/field-select.jsp/field-hidden-readonly.jsp/
     *   field-filler.jsp). On cherche l'ancêtre tagué le plus proche ; s'il
     *   porte au moins un des deux attributs non vide, on tranche ici.
     * - ANCIEN (en-tête, final — inchangés) : wrapper .base-type-block /
     *   .base-block autour de tout un bloc. On ne l'utilise que si aucun
     *   ancêtre data-bases/data-types pertinent n'a été trouvé, pour ne
     *   pas casser ces sections qui réutilisent les mêmes field-*.jsp
     *   (lesquels posent toujours data-bases="" / data-types="" par
     *   défaut — un attribut VIDE ne doit jamais l'emporter sur le
     *   wrapper .base-block englobant).
     */
    _isActive(input, base, typeDossier) {
        const tagged = input.closest('[data-bases], [data-types]');
        if (tagged && (tagged.dataset.bases || tagged.dataset.types)) {
            const basesAttr = (tagged.dataset.bases || '').trim();
            const typesAttr = (tagged.dataset.types || '').trim();
            const basesOk = !basesAttr || basesAttr.split(/\s+/).includes(base);
            const typesOk = !typesAttr || typesAttr.split(/\s+/).includes(typeDossier);
            return basesOk && typesOk;
        }

        const baseTypeBlock = input.closest('.base-type-block');
        if (baseTypeBlock) {
            return baseTypeBlock.dataset.base === base && baseTypeBlock.dataset.type === typeDossier;
        }
        const baseBlock = input.closest('.base-block');
        if (baseBlock) {
            return baseBlock.dataset.base === base;
        }
        return true;
    },


    _extractFieldElements(templateHtml) {
        const container = document.createElement('div');
        container.innerHTML = templateHtml;
        const base = this.getBase();

        const visible = [];
        const hidden = [];
        const labels = [];
        const columns = [];

        container.querySelectorAll('.input-container, .form-select').forEach(field => {
            const basesAttr = (field.dataset.bases || '').trim();
            if (basesAttr && !basesAttr.split(/\s+/).includes(base)) return; // pas cette base : ignoré

            const isHidden = /display\s*:\s*none/i.test(field.getAttribute('style') || '')
                || field.classList.contains('sybris-readonly-field');
            const control = field.querySelector('input, select, textarea');
            if (!control || !control.name) return;

            const labelEl = field.querySelector('label');
            const label = labelEl ? labelEl.textContent.trim() : control.name;

            if (isHidden) {
                hidden.push(control.outerHTML);
            } else {
                labels.push(label);
                columns.push({ label, name: control.name });
                visible.push(control.outerHTML);
            }
        });

        return { visible, hidden, labels, columns };
    },

    _suffixIds(html, suffix) {
        return html
            .replace(/id="([^"]+)"/g, `id="$1-${suffix}"`)
            .replace(/for="([^"]+)"/g, `for="$1-${suffix}"`);
    },


    _escapeHtml(value) {
        return String(value || '')
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }
};
