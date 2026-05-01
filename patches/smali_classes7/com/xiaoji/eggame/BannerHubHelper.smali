.class public Lcom/xiaoji/eggame/BannerHubHelper;
.super Ljava/lang/Object;
.source "BannerHubHelper.smali"

# Static method to add BannerHub tabs to an Activity
# Usage: invoke-static {p0}, Lcom/xiaoji/eggame/BannerHubHelper;->addTabsToActivity(Landroid/app/Activity;)V

.method public static addTabsToActivity(Landroid/app/Activity;)V
    .locals 5

    .line 1
    if-eqz p0, :done

    # v0 = getWindow().getDecorView()
    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;
    move-result-object v0
    if-eqz v0, :done
    
    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;
    move-result-object v0
    if-eqz v0, :done
    
    check-cast v0, Landroid/view/ViewGroup;

    .line 2
    # Create horizontal LinearLayout for tabs
    new-instance v1, Landroid/widget/LinearLayout;
    invoke-direct {v1, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V
    
    const/4 v2, 0x0  # HORIZONTAL
    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 3
    # Create GOG button
    new-instance v2, Landroid/widget/Button;
    invoke-direct {v2, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v3, "GOG"
    invoke-virtual {v2, v3}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 4
    # Create Epic button
    new-instance v2, Landroid/widget/Button;
    invoke-direct {v2, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v3, "Epic"
    invoke-virtual {v2, v3}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 5
    # Create Amazon button
    new-instance v2, Landroid/widget/Button;
    invoke-direct {v2, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v3, "Amazon"
    invoke-virtual {v2, v3}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 6
    # Add tab bar to decor view
    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    :done
    return-void
.end method

# Default constructor
.method public constructor <init>()V
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.end class
