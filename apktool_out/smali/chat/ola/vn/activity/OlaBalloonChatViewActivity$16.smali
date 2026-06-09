.class Lchat/ola/vn/activity/OlaBalloonChatViewActivity$16;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->af()V
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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$16;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$16;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget v0, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$16;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget v0, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$16;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)I

    move-result v1

    if-eq v0, v1, :cond_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$16;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$16;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)I

    move-result v1

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$16;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_1
    return-void
.end method
