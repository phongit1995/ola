.class Lchat/ola/vn/activity/OlaBalloonChatViewActivity$8;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/animation/Animation$AnimationListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$8;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationEnd(Landroid/view/animation/Animation;)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$8;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->k(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/Button;

    move-result-object p1

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$8;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    const v0, 0x7f01000f

    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    const-wide/16 v0, 0xc8

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$8;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/ImageButton;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/widget/ImageButton;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$8;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/ImageButton;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onAnimationRepeat(Landroid/view/animation/Animation;)V
    .locals 0

    return-void
.end method

.method public onAnimationStart(Landroid/view/animation/Animation;)V
    .locals 0

    return-void
.end method
