.class Lchat/ola/vn/activity/OlaChatViewActivity$11$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity$11$1;->a(Lchat/ola/vn/entity/i;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/i;

.field final synthetic b:Lchat/ola/vn/activity/OlaChatViewActivity$11$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity$11$1;Lchat/ola/vn/entity/i;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$11$1$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$11$1;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$11$1$1;->a:Lchat/ola/vn/entity/i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$11$1$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$11$1;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaChatViewActivity$11$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$11;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaChatViewActivity$11;->c:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$11$1$1;->a:Lchat/ola/vn/entity/i;

    invoke-virtual {v2}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$11$1$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$11$1;

    iget-object v3, v3, Lchat/ola/vn/activity/OlaChatViewActivity$11$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$11;

    iget-object v3, v3, Lchat/ola/vn/activity/OlaChatViewActivity$11;->a:Lchat/ola/vn/message/aa;

    invoke-virtual {v3}, Lchat/ola/vn/message/aa;->p()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
