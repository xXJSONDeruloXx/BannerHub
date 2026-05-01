.class public Lcom/winemu/ui/BhFolderListener;
.super Ljava/lang/Object;
.source "SourceFile"

# onClick: navigate into the given absolute directory path in the Launch tab.

.implements Landroid/view/View$OnClickListener;

.field public final fragment:Lcom/winemu/ui/BhTaskManagerFragment;
.field public final path:Ljava/lang/String;

.method public constructor <init>(Lcom/winemu/ui/BhTaskManagerFragment;Ljava/lang/String;)V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/winemu/ui/BhFolderListener;->fragment:Lcom/winemu/ui/BhTaskManagerFragment;
    iput-object p2, p0, Lcom/winemu/ui/BhFolderListener;->path:Ljava/lang/String;
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2
    iget-object v0, p0, Lcom/winemu/ui/BhFolderListener;->fragment:Lcom/winemu/ui/BhTaskManagerFragment;
    iget-object v1, p0, Lcom/winemu/ui/BhFolderListener;->path:Ljava/lang/String;
    invoke-virtual {v0, v1}, Lcom/winemu/ui/BhTaskManagerFragment;->browseTo(Ljava/lang/String;)V
    return-void
.end method
