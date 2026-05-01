.class public Lcom/winemu/ui/BhTaskManagerFragment$RefreshListener;
.super Ljava/lang/Object;
.source "SourceFile"

# onClick for the Refresh button — just re-triggers startScan().

.implements Landroid/view/View$OnClickListener;

.field public final fragment:Lcom/winemu/ui/BhTaskManagerFragment;

.method public constructor <init>(Lcom/winemu/ui/BhTaskManagerFragment;)V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/winemu/ui/BhTaskManagerFragment$RefreshListener;->fragment:Lcom/winemu/ui/BhTaskManagerFragment;
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 0
    iget-object p0, p0, Lcom/winemu/ui/BhTaskManagerFragment$RefreshListener;->fragment:Lcom/winemu/ui/BhTaskManagerFragment;
    invoke-virtual {p0}, Lcom/winemu/ui/BhTaskManagerFragment;->startScan()V
    return-void
.end method
