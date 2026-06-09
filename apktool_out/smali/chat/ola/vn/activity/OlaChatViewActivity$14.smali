.class Lchat/ola/vn/activity/OlaChatViewActivity$14;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->ai()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$14;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4

    if-nez p2, :cond_1

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p2, :cond_0

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$14;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->k(Ljava/lang/String;)V

    :cond_0
    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$14;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$14;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/message/g;->a(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$14;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    const v0, 0x7f0f030f

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-object v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$14;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v3}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {p2, v0, v1}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;I[Ljava/lang/Object;)V

    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$14;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/m/e;->b(Landroid/content/Context;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$14;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->finish()V

    return-void

    :cond_1
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
