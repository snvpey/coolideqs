// ============ INDEX.JS - POINT D'ENTRÉE ============

/**
 * Point d'entrée de l'application Sybris.
 * Initialise les modules au chargement de la page.
 *
 * Le flux (dossiers + entête + final) n'est plus injecté en dur dans le JSP
 * (l'ancienne variable window.initialDossiersValides restait toujours à []
 * quel que soit le contenu réel de la session) : on le récupère désormais
 * via /sybris/flux, seule source fiable de l'état serveur.
 */
document.addEventListener('DOMContentLoaded', function() {
    SybrisPayload.init();
    SybrisUI.initRiskConstraints();
    SybrisUI.initConditionalStars();

    SybrisApi.getFlux()
        .then(flux => SybrisUI.displayFlux(flux))
        .catch(error => console.error('Erreur chargement initial du flux:', error));
});
