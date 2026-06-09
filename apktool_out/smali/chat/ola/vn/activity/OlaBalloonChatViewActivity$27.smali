.class Lchat/ola/vn/activity/OlaBalloonChatViewActivity$27;
.super Lcom/mg/ola/a/a/b/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Z

.field final synthetic b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Z)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$27;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    iput-boolean p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$27;->a:Z

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/b;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/mg/ola/a/a/b/a;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$27;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Lcom/mg/ola/a/a/b/c;)Lcom/mg/ola/a/a/b/c;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$27;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/view/View;

    move-result-object p1

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-boolean p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$27;->a:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$27;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->g(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    :cond_0
    return-void
.end method

.method public b(Lcom/mg/ola/a/a/b/a;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$27;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/view/View;

    move-result-object p1

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-boolean p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$27;->a:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$27;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->g(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    :cond_0
    return-void
.end method
