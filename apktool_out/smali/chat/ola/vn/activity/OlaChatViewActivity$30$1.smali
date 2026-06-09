.class Lchat/ola/vn/activity/OlaChatViewActivity$30$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/u/o;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity$30;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/ab;

.field final synthetic b:Lchat/ola/vn/activity/OlaChatViewActivity$30;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity$30;Lchat/ola/vn/entity/ab;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$30;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->a:Lchat/ola/vn/entity/ab;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a()V
    .locals 3

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$30;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaChatViewActivity$30;->b:Lchat/ola/vn/message/p;

    invoke-virtual {v1}, Lchat/ola/vn/message/p;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$30;

    iget-object v2, v2, Lchat/ola/vn/activity/OlaChatViewActivity$30;->b:Lchat/ola/vn/message/p;

    invoke-virtual {v2}, Lchat/ola/vn/message/p;->s()S

    move-result v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$30;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaChatViewActivity$30;->b:Lchat/ola/vn/message/p;

    invoke-virtual {v1}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->o(Ljava/lang/String;)Lchat/ola/vn/message/d;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/p;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lchat/ola/vn/message/p;->a()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->a:Lchat/ola/vn/entity/ab;

    invoke-interface {v1, v2}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/p;->b(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method


# virtual methods
.method public a(II)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/i;)V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->a:Lchat/ola/vn/entity/ab;

    const/4 v1, 0x0

    iput-byte v1, v0, Lchat/ola/vn/entity/ab;->b:B

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->a:Lchat/ola/vn/entity/ab;

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$30;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaChatViewActivity$30;->b:Lchat/ola/vn/message/p;

    invoke-virtual {v0}, Lchat/ola/vn/message/p;->j()Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$30;

    iget-object v2, v2, Lchat/ola/vn/activity/OlaChatViewActivity$30;->b:Lchat/ola/vn/message/p;

    invoke-virtual {v2}, Lchat/ola/vn/message/p;->s()S

    move-result v2

    invoke-virtual {p1, v0, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object p1

    if-eqz p1, :cond_3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$30;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaChatViewActivity$30;->b:Lchat/ola/vn/message/p;

    invoke-virtual {v0}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/f;->o(Ljava/lang/String;)Lchat/ola/vn/message/d;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/p;

    if-eqz p1, :cond_3

    invoke-virtual {p1}, Lchat/ola/vn/message/p;->a()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_3

    const-string v0, ""

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    const/4 v3, 0x1

    if-eqz v2, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/ab;

    iget-byte v4, v2, Lchat/ola/vn/entity/ab;->b:B

    if-ne v4, v3, :cond_0

    const/4 v3, 0x0

    goto :goto_1

    :cond_0
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "##"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, v2, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "#"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " ##"

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, v2, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "#"

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_2
    :goto_1
    if-eqz v3, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$30;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaChatViewActivity$30;->d:Lchat/ola/vn/activity/OlaChatViewActivity;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$30;

    iget-object v2, v2, Lchat/ola/vn/activity/OlaChatViewActivity$30;->c:Lchat/ola/vn/message/f;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$30;

    iget-object v3, v3, Lchat/ola/vn/activity/OlaChatViewActivity$30;->b:Lchat/ola/vn/message/p;

    invoke-virtual {v3}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v3

    invoke-static {p1, v2, v0, v1, v3}, Lchat/ola/vn/activity/OlaChatViewActivity;->b(Lchat/ola/vn/activity/OlaChatViewActivity;Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$30;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaChatViewActivity$30;->c:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    const/4 v0, 0x4

    if-ne p1, v0, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->b:Lchat/ola/vn/activity/OlaChatViewActivity$30;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaChatViewActivity$30;->b:Lchat/ola/vn/message/p;

    const/4 v0, 0x2

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/p;->b(B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_3
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->a()V

    return-void
.end method

.method public a(Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->a()V

    return-void
.end method

.method public a(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->a()V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->a()V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity$30$1;->a()V

    return-void
.end method
