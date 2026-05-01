.class public Lcom/winemu/ui/RtsGestureConfigDialog$ResetClickListener;
.super Ljava/lang/Object;
.source "RtsGestureConfigDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;

# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/winemu/ui/RtsGestureConfigDialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "ResetClickListener"
.end annotation

# instance fields
.field final synthetic this$0:Lcom/winemu/ui/RtsGestureConfigDialog;

# direct methods
.method public constructor <init>(Lcom/winemu/ui/RtsGestureConfigDialog;)V
    .locals 0

    iput-object p1, p0, Lcom/winemu/ui/RtsGestureConfigDialog$ResetClickListener;->this$0:Lcom/winemu/ui/RtsGestureConfigDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    # Reset all gesture settings to defaults
    invoke-static {}, Lcom/xj/pcvirtualbtn/inputcontrols/InputControlsManager;->resetRtsGestureSettings()V

    # Refresh the UI to show default values
    iget-object p1, p0, Lcom/winemu/ui/RtsGestureConfigDialog$ResetClickListener;->this$0:Lcom/winemu/ui/RtsGestureConfigDialog;
    invoke-virtual {p1}, Lcom/winemu/ui/RtsGestureConfigDialog;->refreshUI()V

    # Show the dialog again with refreshed values
    iget-object p1, p0, Lcom/winemu/ui/RtsGestureConfigDialog$ResetClickListener;->this$0:Lcom/winemu/ui/RtsGestureConfigDialog;
    invoke-virtual {p1}, Lcom/winemu/ui/RtsGestureConfigDialog;->show()V

    return-void
.end method
