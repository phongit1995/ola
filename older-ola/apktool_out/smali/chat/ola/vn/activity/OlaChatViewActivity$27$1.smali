.class Lchat/ola/vn/activity/OlaChatViewActivity$27$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/u/o;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity$27;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaChatViewActivity$27;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity$27;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(II)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/i;)V
    .locals 7

    const/4 v0, 0x2

    const/4 v1, 0x4

    const/4 v2, 0x0

    :try_start_0
    sget-object v3, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v4, v4, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    invoke-virtual {v4}, Lchat/ola/vn/message/p;->j()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v5, v5, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    invoke-virtual {v5}, Lchat/ola/vn/message/p;->s()S

    move-result v5

    invoke-virtual {v3, v4, v5}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v3

    if-eqz v3, :cond_1

    iget-object v4, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v4, v4, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    invoke-virtual {v4}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lchat/ola/vn/message/f;->o(Ljava/lang/String;)Lchat/ola/vn/message/d;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/message/p;

    if-eqz v3, :cond_1

    invoke-virtual {v3}, Lchat/ola/vn/message/p;->a()Ljava/util/List;

    move-result-object v4

    if-eqz v4, :cond_0

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v5

    if-lez v5, :cond_0

    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/entity/ab;

    iput-byte v2, v5, Lchat/ola/vn/entity/ab;->b:B

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v6

    iput-object v6, v5, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    :cond_0
    invoke-virtual {v3, v4}, Lchat/ola/vn/message/p;->b(Ljava/util/List;)V

    iget-object v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v3, v3, Lchat/ola/vn/activity/OlaChatViewActivity$27;->c:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->k()S

    move-result v3

    if-ne v3, v1, :cond_1

    iget-object v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v3, v3, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    invoke-virtual {v3, v0}, Lchat/ola/vn/message/p;->b(B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v3

    :try_start_1
    invoke-virtual {v3}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    :goto_0
    iget-object v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v3, v3, Lchat/ola/vn/activity/OlaChatViewActivity$27;->c:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->k()S

    move-result v3

    if-eqz v3, :cond_5

    if-eq v3, v0, :cond_3

    if-eq v3, v1, :cond_2

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaChatViewActivity$27;->d:Lchat/ola/vn/activity/OlaChatViewActivity;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaChatViewActivity$27;->c:Lchat/ola/vn/message/f;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "##"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "#"

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v3, v3, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    invoke-virtual {v3}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v1, p1, v2, v3}, Lchat/ola/vn/activity/OlaChatViewActivity;->b(Lchat/ola/vn/activity/OlaChatViewActivity;Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaChatViewActivity$27;->c:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->X()Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaChatViewActivity$27;->d:Lchat/ola/vn/activity/OlaChatViewActivity;

    new-instance v1, Lchat/ola/vn/activity/OlaChatViewActivity$27$1$1;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity$27$1$1;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity$27$1;Lchat/ola/vn/entity/i;)V

    invoke-static {v0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/lang/Runnable;)V

    return-void

    :cond_4
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaChatViewActivity$27;->c:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v2, v2, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    invoke-virtual {v2}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_5
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaChatViewActivity$27;->c:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object v2, v2, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    invoke-virtual {v2}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;I)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaChatViewActivity$27;->d:Lchat/ola/vn/activity/OlaChatViewActivity;

    const v0, 0x7f0f0261

    invoke-virtual {p2, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/p;->l(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    const/4 p2, 0x5

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/p;->b(B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaChatViewActivity$27;->d:Lchat/ola/vn/activity/OlaChatViewActivity;

    const p3, 0x7f0f0260

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/p;->l(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    const/4 p2, 0x5

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/p;->b(B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaChatViewActivity$27;->d:Lchat/ola/vn/activity/OlaChatViewActivity;

    const v0, 0x7f0f0264

    invoke-virtual {p2, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/p;->l(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    const/4 p2, 0x5

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/p;->b(B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/p;->l(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$27$1;->a:Lchat/ola/vn/activity/OlaChatViewActivity$27;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaChatViewActivity$27;->a:Lchat/ola/vn/message/p;

    const/4 p2, 0x5

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/p;->b(B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
