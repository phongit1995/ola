.class Lchat/ola/vn/network/e$59;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(JLjava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic b:Ljava/util/List;

.field final synthetic c:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;JLjava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$59;->c:Lchat/ola/vn/network/e;

    iput-wide p2, p0, Lchat/ola/vn/network/e$59;->a:J

    iput-object p4, p0, Lchat/ola/vn/network/e$59;->b:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-wide v1, p0, Lchat/ola/vn/network/e$59;->a:J

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->a(J)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-wide v1, p0, Lchat/ola/vn/network/e$59;->a:J

    sget-object v3, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    iget-wide v4, p0, Lchat/ola/vn/network/e$59;->a:J

    invoke-virtual {v3, v4, v5}, Lchat/ola/vn/r/a/f;->a(J)Lchat/ola/vn/entity/s;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/entity/s;->d()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/message/g;->a(JLjava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    :cond_0
    if-eqz v0, :cond_1

    iget-object v1, p0, Lchat/ola/vn/network/e$59;->b:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/message/d;

    invoke-virtual {v0, v2}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_1
    return-void
.end method
