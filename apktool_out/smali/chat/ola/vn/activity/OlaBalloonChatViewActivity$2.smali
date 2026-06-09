.class Lchat/ola/vn/activity/OlaBalloonChatViewActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(Z)V
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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$2;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    iput-boolean p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$2;->a:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$2;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/ListView;

    move-result-object v0

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setTranscriptMode(I)V

    iget-boolean v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$2;->a:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$2;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/ListView;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$2;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->c(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Lchat/ola/vn/b/o;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/b/o;->getCount()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->smoothScrollToPosition(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$2;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/ListView;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$2;->b:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->c(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Lchat/ola/vn/b/o;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/b/o;->getCount()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
