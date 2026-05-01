.class public final Lcom/winemu/ui/BhTaskClickListener;
.super Ljava/lang/Object;
.source "SourceFile"

# Sidebar tab click listener for the Wine Task Manager tab.
# Implements Function0 (Kotlin lambda) — same pattern as k1, m1, o1.

.implements Lkotlin/jvm/functions/Function0;

.field public final a:Lcom/winemu/ui/WineActivityDrawerContent;

.method public constructor <init>(Lcom/winemu/ui/WineActivityDrawerContent;)V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/winemu/ui/BhTaskClickListener;->a:Lcom/winemu/ui/WineActivityDrawerContent;
    return-void
.end method

.method public final invoke()Ljava/lang/Object;
    .locals 1
    iget-object p0, p0, Lcom/winemu/ui/BhTaskClickListener;->a:Lcom/winemu/ui/WineActivityDrawerContent;
    const-string v0, "BhTaskManagerFragment"
    invoke-virtual {p0, v0}, Lcom/winemu/ui/WineActivityDrawerContent;->U(Ljava/lang/String;)V
    sget-object p0, Lkotlin/Unit;->a:Lkotlin/Unit;
    return-object p0
.end method
