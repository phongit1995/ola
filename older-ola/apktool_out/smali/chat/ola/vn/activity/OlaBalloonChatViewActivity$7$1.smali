.class Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/u/o;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(II)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->b:Ljava/lang/String;

    invoke-virtual {v0, v1, p1, p2}, Lchat/ola/vn/message/aa;->d(Ljava/lang/String;II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/i;)V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->b:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/aa;->b(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->c:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x2

    const/4 v2, 0x4

    if-ne v0, v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/aa;->b(B)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->c:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-eqz v0, :cond_3

    if-eq v0, v1, :cond_2

    if-eq v0, v2, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->d:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->c:Lchat/ola/vn/message/f;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "##"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "#"

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v2, 0x0

    iget-object v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v3, v3, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    invoke-virtual {v3}, Lchat/ola/vn/message/aa;->p()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v1, p1, v2, v3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V

    return-void

    :cond_2
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->c:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v2, v2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    invoke-virtual {v2}, Lchat/ola/vn/message/aa;->p()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_3
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->c:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v2, v2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    invoke-virtual {v2}, Lchat/ola/vn/message/aa;->p()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/aa;->p(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;I)V
    .locals 2

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->d:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    const v1, 0x7f0f0261

    invoke-virtual {v0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/message/aa;->l(Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    const/4 v0, 0x5

    invoke-virtual {p2, v0}, Lchat/ola/vn/message/aa;->b(B)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    invoke-virtual {p2, p1}, Lchat/ola/vn/message/aa;->q(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;ILjava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    iget-object p3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object p3, p3, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->d:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    const v0, 0x7f0f0260

    invoke-virtual {p3, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Lchat/ola/vn/message/aa;->l(Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    const/4 p3, 0x5

    invoke-virtual {p2, p3}, Lchat/ola/vn/message/aa;->b(B)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    invoke-virtual {p2, p1}, Lchat/ola/vn/message/aa;->q(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->d:Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    const v1, 0x7f0f0264

    invoke-virtual {v0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/message/aa;->l(Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    const/4 v0, 0x5

    invoke-virtual {p2, v0}, Lchat/ola/vn/message/aa;->b(B)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    invoke-virtual {p2, p1}, Lchat/ola/vn/message/aa;->q(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    invoke-virtual {v0, p2}, Lchat/ola/vn/message/aa;->l(Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    const/4 v0, 0x5

    invoke-virtual {p2, v0}, Lchat/ola/vn/message/aa;->b(B)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7$1;->a:Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;->a:Lchat/ola/vn/message/aa;

    invoke-virtual {p2, p1}, Lchat/ola/vn/message/aa;->q(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
