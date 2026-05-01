.class public Lcom/winemu/ui/RtsGestureConfigDialog$AppPopupDismissListener;
.super Ljava/lang/Object;
.implements Landroidx/appcompat/widget/PopupMenu$OnDismissListener;

# instance fields
.field private final owner:Lcom/winemu/ui/RtsGestureConfigDialog;

# direct methods
.method public constructor <init>(Lcom/winemu/ui/RtsGestureConfigDialog;)V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/winemu/ui/RtsGestureConfigDialog$AppPopupDismissListener;->owner:Lcom/winemu/ui/RtsGestureConfigDialog;
    return-void
.end method

# virtual methods
.method public onDismiss(Landroidx/appcompat/widget/PopupMenu;)V
    .locals 1
    iget-object v0, p0, Lcom/winemu/ui/RtsGestureConfigDialog$AppPopupDismissListener;->owner:Lcom/winemu/ui/RtsGestureConfigDialog;
    invoke-virtual {v0}, Lcom/winemu/ui/RtsGestureConfigDialog;->applyPendingSelectionIfAny()V
    return-void
.end method
