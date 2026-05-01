.class public final synthetic Lcom/winemu/ui/RtsGestureSettingsClickListener;
.super Ljava/lang/Object;
.source "RtsGestureSettingsClickListener.java"

# interfaces
.implements Landroid/view/View$OnClickListener;

# instance fields
.field public final synthetic fragment:Lcom/winemu/ui/SidebarControlsFragment;

# direct methods
.method public synthetic constructor <init>(Lcom/winemu/ui/SidebarControlsFragment;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/winemu/ui/RtsGestureSettingsClickListener;->fragment:Lcom/winemu/ui/SidebarControlsFragment;

    return-void
.end method

# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    # Get context from fragment
    iget-object v0, p0, Lcom/winemu/ui/RtsGestureSettingsClickListener;->fragment:Lcom/winemu/ui/SidebarControlsFragment;
    invoke-virtual {v0}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;
    move-result-object v0

    if-eqz v0, :cond_0

    # Create and show the dialog
    new-instance v1, Lcom/winemu/ui/RtsGestureConfigDialog;
    invoke-direct {v1, v0}, Lcom/winemu/ui/RtsGestureConfigDialog;-><init>(Landroid/content/Context;)V
    invoke-virtual {v1}, Lcom/winemu/ui/RtsGestureConfigDialog;->show()V

    :cond_0
    return-void
.end method
