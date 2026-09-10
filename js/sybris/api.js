/**
 * Module API - Centralise tous les appels au backend Sybris.
 */
const SybrisApi = {
    ctx: window.contextPath || '',

    /**
     * Récupère l'état courant du flux (dossiers + entête + final).
     * Appelé au chargement de la page pour réafficher un flux existant en
     * session, puisque le JSP ne le sérialise plus côté serveur.
     */
    async getFlux() {
        const response = await fetch(this.ctx + '/sybris/flux');
        if (!response.ok) {
            throw new Error('Erreur HTTP ' + response.status);
        }
        return response.json();
    },

    /**
     * Prévisualise un dossier (déclaration ou prolongation) pour une base donnée.
     * @param {'DECLARATION'|'PROLONGATION'} type
     * @param {'A'|'B'|'C'} base
     * @param {object} payload
     */
    async preview(type, base, payload) {
        const suffix = type === 'DECLARATION' ? 'declaration' : 'prolongation';
        const endpoint = `/sybris/preview-${suffix}-base${base}`;

        const response = await fetch(this.ctx + endpoint, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify(payload)
        });
        if (!response.ok) {
            throw new Error('Erreur HTTP ' + response.status);
        }
        return response.json();
    },

    /**
     * Prévisualise l'enregistrement En-tête (type 01) pour une base donnée.
     * @param {'A'|'B'|'C'} base
     * @param {object} payload
     */
    async previewEntete(base, payload) {
        let endpoint = `/sybris/preview-entete`;
        if (base=='A') {
            endpoint += '-baseA';
        }

        const response = await fetch(this.ctx + endpoint, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify(payload)
        });
        if (!response.ok) {
            throw new Error('Erreur HTTP ' + response.status);
        }
        return response.json();
    },

    /**
     * Prévisualise l'enregistrement Final (type 09) pour une base donnée.
     * @param {'A'|'B'|'C'} base
     * @param {object} payload
     */
    async previewFinal(base, payload) {
        let endpoint = `/sybris/preview-final`;
        if (base=='A') {
            endpoint += '-baseA';
        }

        const response = await fetch(this.ctx + endpoint, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify(payload)
        });
        if (!response.ok) {
            throw new Error('Erreur HTTP ' + response.status);
        }
        return response.json();
    },

    /**
     * Efface la prévisualisation en cours.
     */
    async clearPreview() {
        const response = await fetch(this.ctx + '/sybris/clear-preview', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' }
        });

        if (!response.ok) {
            throw new Error('Erreur effacement');
        }
        return response.json();
    },

    /**
     * Ajoute le dossier/entête/final prévisualisé au flux.
     */
    async addToFlux() {
        const response = await fetch(this.ctx + '/sybris/add-to-flux', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' }
        });

        if (!response.ok) {
            throw new Error('Erreur ajout au flux');
        }
        return response.json();
    },

    /**
     * Vide le flux complet.
     */
    async clearFlux() {
        const response = await fetch(this.ctx + '/sybris/clear-flux', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' }
        });

        if (!response.ok) {
            throw new Error('Erreur vidage flux');
        }
        return response.json();
    },

    /**
     * Déclenche le téléchargement du flux.
     */
    telecharger() {
        window.location.href = this.ctx + '/sybris/telecharger-dossiers';
    }
};
