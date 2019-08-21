({
    doInit: function(component, event, helper) {

        helper.showHide(component);
        // pb du getcharge reference qui passe en asycnhrone. la refrecnce est vide.
        // pb handle init: si appel  adddclass ..etc ca ne marche pas il faut que ca soit dans le onload du recordeditform
    }
})