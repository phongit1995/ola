.class Lchat/ola/vn/activity/OlaChatViewActivity$13;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->h(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Z

.field final synthetic b:Lchat/ola/vn/activity/OlaChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity;Z)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$13;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    iput-boolean p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$13;->a:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$13;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->l(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/b/o;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/b/o;->getCount()I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$13;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->m(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/ListView;

    move-result-object v1

    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Landroid/widget/ListView;->setTranscriptMode(I)V

    iget-boolean v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$13;->a:Z

    if-eqz v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$13;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->m(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/ListView;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/ListView;->getLastVisiblePosition()I

    move-result v1

    sub-int v1, v0, v1

    const/16 v2, 0x1e

    if-lt v1, v2, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$13;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    :goto_0
    invoke-static {v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->m(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/ListView;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->setSelection(I)V

    return-void

    :cond_0
    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$13;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->m(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/ListView;

    move-result-object v1

    const/4 v2, 0x0

    const/16 v3, 0x1f4

    invoke-virtual {v1, v0, v2, v3}, Landroid/widget/ListView;->smoothScrollToPositionFromTop(III)V

    return-void

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$13;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->m(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/ListView;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->smoothScrollToPosition(I)V

    return-void

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$13;->b:Lchat/ola/vn/activity/OlaChatViewActivity;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method
