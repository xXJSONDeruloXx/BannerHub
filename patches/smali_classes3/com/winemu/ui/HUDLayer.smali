.class public final Lcom/winemu/ui/HUDLayer;
.super Landroid/widget/FrameLayout;
.source "r8-map-id-60560d24e8bcc45c0b2a1383d0d901f6ddb757a48af5ae5971565c863742b7e9"


# static fields
.field public static final synthetic o:I


# instance fields
.field public final a:Landroid/widget/LinearLayout;

.field public final b:Lcom/winemu/ui/UnifiedHUDView;

.field public c:Z

.field public d:F

.field public e:F

.field public f:Z

.field public g:J

.field public final h:J

.field public final i:F

.field public j:Z

.field public final k:Landroid/content/SharedPreferences;

.field public final l:Landroid/os/Handler;

.field public m:Ljc9;

.field public final n:J


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 5

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    invoke-direct {p0, p1, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 5
    .line 6
    .line 7
    new-instance p2, Landroid/widget/LinearLayout;

    .line 8
    .line 9
    invoke-direct {p2, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 10
    .line 11
    .line 12
    iput-object p2, p0, Lcom/winemu/ui/HUDLayer;->a:Landroid/widget/LinearLayout;

    .line 13
    .line 14
    new-instance v0, Lcom/winemu/ui/UnifiedHUDView;

    .line 15
    .line 16
    invoke-direct {v0, p1}, Lcom/winemu/ui/UnifiedHUDView;-><init>(Landroid/content/Context;)V

    .line 17
    .line 18
    .line 19
    iput-object v0, p0, Lcom/winemu/ui/HUDLayer;->b:Lcom/winemu/ui/UnifiedHUDView;

    .line 20
    .line 21
    const-wide/16 v1, 0xc8

    .line 22
    .line 23
    iput-wide v1, p0, Lcom/winemu/ui/HUDLayer;->h:J

    .line 24
    .line 25
    const/high16 v1, 0x41200000    # 10.0f

    .line 26
    .line 27
    iput v1, p0, Lcom/winemu/ui/HUDLayer;->i:F

    .line 28
    .line 29
    const-string v1, "hud_prefs"

    .line 30
    .line 31
    const/4 v2, 0x0

    .line 32
    invoke-virtual {p1, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    .line 33
    .line 34
    .line 35
    move-result-object p1

    .line 36
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 37
    .line 38
    .line 39
    iput-object p1, p0, Lcom/winemu/ui/HUDLayer;->k:Landroid/content/SharedPreferences;

    .line 40
    .line 41
    new-instance v1, Landroid/os/Handler;

    .line 42
    .line 43
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    .line 44
    .line 45
    .line 46
    move-result-object v3

    .line 47
    invoke-direct {v1, v3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 48
    .line 49
    .line 50
    iput-object v1, p0, Lcom/winemu/ui/HUDLayer;->l:Landroid/os/Handler;

    .line 51
    .line 52
    const-wide/16 v3, 0x3e8

    .line 53
    .line 54
    iput-wide v3, p0, Lcom/winemu/ui/HUDLayer;->n:J

    .line 55
    .line 56
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;

    .line 57
    .line 58
    const/4 v3, -0x2

    .line 59
    invoke-direct {v1, v3, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    .line 60
    .line 61
    .line 62
    invoke-virtual {p2, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 63
    .line 64
    .line 65
    invoke-virtual {p2, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 66
    .line 67
    .line 68
    invoke-virtual {p2, v2}, Landroid/view/ViewGroup;->setClipChildren(Z)V

    .line 69
    .line 70
    .line 71
    invoke-virtual {p0, p2}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 72
    .line 73
    .line 74
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;

    .line 75
    .line 76
    const/4 v3, -0x1

    .line 77
    invoke-direct {v1, v3, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    .line 78
    .line 79
    .line 80
    invoke-virtual {v0, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 81
    .line 82
    .line 83
    invoke-virtual {p2, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 84
    .line 85
    .line 86
    new-instance p2, Lkc9;

    .line 87
    .line 88
    invoke-direct {p2, p0, v2}, Lkc9;-><init>(Landroid/view/ViewGroup;I)V

    .line 89
    .line 90
    .line 91
    invoke-virtual {v0, p2}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 92
    .line 93
    .line 94
    new-instance p2, Lef4;

    .line 95
    .line 96
    const/16 v1, 0x1a

    .line 97
    .line 98
    invoke-direct {p2, p0, v1}, Lef4;-><init>(Ljava/lang/Object;I)V

    .line 99
    .line 100
    .line 101
    invoke-virtual {v0, p2}, Lcom/winemu/ui/UnifiedHUDView;->setOnLayoutChangedListener(Lyq6;)V

    .line 102
    .line 103
    .line 104
    new-instance p2, Ljc9;

    .line 105
    .line 106
    const/4 v1, 0x1

    .line 107
    invoke-direct {p2, p0, v1}, Ljc9;-><init>(Lcom/winemu/ui/HUDLayer;I)V

    .line 108
    .line 109
    .line 110
    invoke-virtual {p0, p2}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    .line 111
    .line 112
    .line 113
    const-string p0, "hud_vertical_layout"

    .line 114
    .line 115
    invoke-interface {p1, p0, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    .line 116
    .line 117
    .line 118
    move-result p0

    .line 119
    invoke-virtual {v0, p0}, Lcom/winemu/ui/UnifiedHUDView;->setVerticalLayout(Z)V

    .line 120
    .line 121
    .line 122
    return-void
.end method


# virtual methods
.method public final getBackgroundAlpha()F
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/winemu/ui/HUDLayer;->b:Lcom/winemu/ui/UnifiedHUDView;

    .line 2
    .line 3
    invoke-virtual {p0}, Lcom/winemu/ui/UnifiedHUDView;->getBackgroundAlpha()F

    .line 4
    .line 5
    .line 6
    move-result p0

    .line 7
    return p0
.end method

.method public final getUnifiedHudView()Lcom/winemu/ui/UnifiedHUDView;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/winemu/ui/HUDLayer;->b:Lcom/winemu/ui/UnifiedHUDView;

    .line 2
    .line 3
    return-object p0
.end method

.method public final onLayout(ZIIII)V
    .locals 0

    .line 1
    invoke-super/range {p0 .. p5}, Landroid/widget/FrameLayout;->onLayout(ZIIII)V

    .line 2
    .line 3
    .line 4
    new-instance p1, Ljc9;

    .line 5
    .line 6
    const/4 p2, 0x0

    .line 7
    invoke-direct {p1, p0, p2}, Ljc9;-><init>(Lcom/winemu/ui/HUDLayer;I)V

    .line 8
    .line 9
    .line 10
    invoke-virtual {p0, p1}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    .line 11
    .line 12
    .line 13
    return-void
.end method

.method public final setBackgroundAlpha(F)V
    .locals 2

    .line 1
    const/4 v0, 0x0

    .line 2
    const/high16 v1, 0x3f800000    # 1.0f

    .line 3
    .line 4
    invoke-static {p1, v0, v1}, Ljc6;->x(FFF)F

    .line 5
    .line 6
    .line 7
    move-result p1

    .line 8
    iget-object p0, p0, Lcom/winemu/ui/HUDLayer;->b:Lcom/winemu/ui/UnifiedHUDView;

    .line 9
    .line 10
    invoke-virtual {p0, p1}, Lcom/winemu/ui/UnifiedHUDView;->setBackgroundAlpha(F)V

    .line 11
    .line 12
    .line 13
    return-void
.end method

.method public final setDirectRenderingEnabled(Z)V
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/winemu/ui/HUDLayer;->b:Lcom/winemu/ui/UnifiedHUDView;

    .line 2
    .line 3
    invoke-virtual {p0, p1}, Lcom/winemu/ui/UnifiedHUDView;->setDirectRenderingEnabled(Z)V

    .line 4
    .line 5
    .line 6
    return-void
.end method

.method public final setEngineName(Ljava/lang/String;)V
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/winemu/ui/HUDLayer;->b:Lcom/winemu/ui/UnifiedHUDView;

    .line 2
    .line 3
    invoke-virtual {p0, p1}, Lcom/winemu/ui/UnifiedHUDView;->setEngineName(Ljava/lang/String;)V

    .line 4
    .line 5
    .line 6
    return-void
.end method

.method public final setScale(F)V
    .locals 2

    .line 1
    new-instance v0, La85;

    .line 2
    .line 3
    const/4 v1, 0x1

    .line 4
    invoke-direct {v0, p0, p1, v1}, La85;-><init>(Ljava/lang/Object;FI)V

    .line 5
    .line 6
    .line 7
    invoke-virtual {p0, v0}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    .line 8
    .line 9
    .line 10
    return-void
.end method
