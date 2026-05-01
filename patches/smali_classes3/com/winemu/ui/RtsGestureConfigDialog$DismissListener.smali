.class public Lcom/winemu/ui/RtsGestureConfigDialog$DismissListener;
.super Ljava/lang/Object;
.implements Landroid/content/DialogInterface$OnDismissListener;

# instance fields
.field private final owner:Lcom/winemu/ui/RtsGestureConfigDialog;

# direct methods
.method public constructor <init>(Lcom/winemu/ui/RtsGestureConfigDialog;)V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/winemu/ui/RtsGestureConfigDialog$DismissListener;->owner:Lcom/winemu/ui/RtsGestureConfigDialog;
    return-void
.end method

# virtual methods
.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 2
    :try_start
    iget-object v0, p0, Lcom/winemu/ui/RtsGestureConfigDialog$DismissListener;->owner:Lcom/winemu/ui/RtsGestureConfigDialog;
    invoke-virtual {v0}, Lcom/winemu/ui/RtsGestureConfigDialog;->applyPendingSelectionIfAny()V
    :try_end
    .catch Ljava/lang/Throwable; {:try_start .. :try_end} :catch_err
    return-void

    :catch_err
    const/4 v1, 0x0
    return-void
.end method
