.class Lchat/ola/vn/network/e$38;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/String;SLchat/ola/vn/message/v;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/message/v;

.field final synthetic c:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;Lchat/ola/vn/message/v;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$38;->c:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$38;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/e$38;->b:Lchat/ola/vn/message/v;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$38;->a:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-eqz v0, :cond_8

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->h()S

    move-result v1

    const/4 v2, -0x1

    if-ne v1, v2, :cond_0

    iget-object v1, p0, Lchat/ola/vn/network/e$38;->b:Lchat/ola/vn/message/v;

    iget-byte v1, v1, Lchat/ola/vn/message/v;->H:B

    int-to-short v1, v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->c(S)V

    :cond_0
    invoke-virtual {v0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/network/e$38;->b:Lchat/ola/vn/message/v;

    iget-object v1, v1, Lchat/ola/vn/message/v;->B:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;)V

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/network/e$38;->b:Lchat/ola/vn/message/v;

    invoke-virtual {v1}, Lchat/ola/vn/message/v;->k()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lchat/ola/vn/network/e$38;->b:Lchat/ola/vn/message/v;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->d()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lchat/ola/vn/message/v;->f(Ljava/lang/String;)V

    :cond_3
    invoke-virtual {v0}, Lchat/ola/vn/message/f;->r()B

    move-result v1

    if-ne v1, v2, :cond_4

    iget-object v1, p0, Lchat/ola/vn/network/e$38;->b:Lchat/ola/vn/message/v;

    iget-byte v1, v1, Lchat/ola/vn/message/v;->F:B

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->a(B)V

    goto :goto_0

    :cond_4
    iget-object v1, p0, Lchat/ola/vn/network/e$38;->b:Lchat/ola/vn/message/v;

    iget-byte v1, v1, Lchat/ola/vn/message/v;->F:B

    if-ne v1, v2, :cond_5

    iget-object v1, p0, Lchat/ola/vn/network/e$38;->b:Lchat/ola/vn/message/v;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->r()B

    move-result v2

    iput-byte v2, v1, Lchat/ola/vn/message/v;->F:B

    :cond_5
    :goto_0
    invoke-virtual {v0}, Lchat/ola/vn/message/f;->i()S

    move-result v1

    if-gtz v1, :cond_6

    iget-object v1, p0, Lchat/ola/vn/network/e$38;->b:Lchat/ola/vn/message/v;

    iget-byte v1, v1, Lchat/ola/vn/message/v;->I:B

    int-to-short v1, v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->e(S)V

    goto :goto_1

    :cond_6
    iget-object v1, p0, Lchat/ola/vn/network/e$38;->b:Lchat/ola/vn/message/v;

    iget-byte v1, v1, Lchat/ola/vn/message/v;->I:B
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-gtz v1, :cond_7

    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/network/e$38;->b:Lchat/ola/vn/message/v;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->i()S

    move-result v2

    int-to-byte v2, v2

    iput-byte v2, v1, Lchat/ola/vn/message/v;->I:B

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/network/e$38;->b:Lchat/ola/vn/message/v;

    iget-byte v2, v2, Lchat/ola/vn/message/v;->I:B

    invoke-virtual {v1, v2}, Lchat/ola/vn/j;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/network/e$38;->b:Lchat/ola/vn/message/v;

    iput-object v1, v2, Lchat/ola/vn/message/v;->z:Lchat/ola/vn/entity/ah;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_7
    :goto_1
    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/network/e$38;->b:Lchat/ola/vn/message/v;

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_8
    return-void
.end method
