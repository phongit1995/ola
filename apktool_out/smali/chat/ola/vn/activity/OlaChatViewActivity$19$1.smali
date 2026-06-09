.class Lchat/ola/vn/activity/OlaChatViewActivity$19$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/i/h$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity$19;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaChatViewActivity$19;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity$19;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$19;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Z)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$19;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/m/e;->b(Landroid/content/Context;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$19;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-virtual {v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->finish()V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$19;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$19$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$19;

    iget-object v2, v2, Lchat/ola/vn/activity/OlaChatViewActivity$19;->b:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    invoke-virtual {v0, v1, v2, p1}, Lchat/ola/vn/message/g;->a(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
