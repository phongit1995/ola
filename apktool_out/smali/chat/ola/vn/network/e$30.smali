.class Lchat/ola/vn/network/e$30;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/String;I[I[I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:[I

.field final synthetic c:I

.field final synthetic d:[I

.field final synthetic e:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;[II[I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$30;->e:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$30;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/e$30;->b:[I

    iput p4, p0, Lchat/ola/vn/network/e$30;->c:I

    iput-object p5, p0, Lchat/ola/vn/network/e$30;->d:[I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/e$30;->a:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$30;->a:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-static {v1, v2}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->Q()Lchat/ola/vn/game/caro/b;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/game/caro/b;->f()Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v3, p0, Lchat/ola/vn/network/e$30;->a:Ljava/lang/String;

    invoke-static {v3, v2}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->Q()Lchat/ola/vn/game/caro/b;

    move-result-object v0

    iget-object v3, p0, Lchat/ola/vn/network/e$30;->b:[I

    aget v3, v3, v2

    iget-object v4, p0, Lchat/ola/vn/network/e$30;->b:[I

    aget v4, v4, v1

    sget-short v5, Lchat/ola/vn/game/caro/a;->a:S

    invoke-virtual {v0, v3, v4, v5}, Lchat/ola/vn/game/caro/b;->a(IIS)V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v3, p0, Lchat/ola/vn/network/e$30;->a:Ljava/lang/String;

    invoke-static {v3, v2}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->Q()Lchat/ola/vn/game/caro/b;

    move-result-object v0

    invoke-virtual {v0, v2}, Lchat/ola/vn/game/caro/b;->a(Z)V

    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v3, p0, Lchat/ola/vn/network/e$30;->a:Ljava/lang/String;

    invoke-static {v3, v2}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->Q()Lchat/ola/vn/game/caro/b;

    move-result-object v0

    iget-object v3, p0, Lchat/ola/vn/network/e$30;->b:[I

    aget v3, v3, v2

    iget-object v4, p0, Lchat/ola/vn/network/e$30;->b:[I

    aget v4, v4, v1

    sget-short v5, Lchat/ola/vn/game/caro/a;->b:S

    invoke-virtual {v0, v3, v4, v5}, Lchat/ola/vn/game/caro/b;->a(IIS)V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v3, p0, Lchat/ola/vn/network/e$30;->a:Ljava/lang/String;

    invoke-static {v3, v2}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->Q()Lchat/ola/vn/game/caro/b;

    move-result-object v0

    invoke-virtual {v0, v1}, Lchat/ola/vn/game/caro/b;->a(Z)V

    const/4 v0, 0x1

    :goto_0
    sget-object v3, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v4, p0, Lchat/ola/vn/network/e$30;->a:Ljava/lang/String;

    invoke-static {v4, v2}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->Q()Lchat/ola/vn/game/caro/b;

    move-result-object v3

    xor-int/2addr v0, v1

    invoke-virtual {v3, v0}, Lchat/ola/vn/game/caro/b;->a(Z)V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$30;->a:Ljava/lang/String;

    invoke-static {v1, v2}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->Q()Lchat/ola/vn/game/caro/b;

    move-result-object v0

    invoke-virtual {v0, v2}, Lchat/ola/vn/game/caro/b;->b(Z)V

    iget-object v0, p0, Lchat/ola/vn/network/e$30;->e:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    iget-object v2, p0, Lchat/ola/vn/network/e$30;->a:Ljava/lang/String;

    iget v3, p0, Lchat/ola/vn/network/e$30;->c:I

    iget-object v4, p0, Lchat/ola/vn/network/e$30;->d:[I

    iget-object v5, p0, Lchat/ola/vn/network/e$30;->b:[I

    invoke-interface {v1, v2, v3, v4, v5}, Lchat/ola/vn/network/f;->a(Ljava/lang/String;I[I[I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-void
.end method
