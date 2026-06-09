.class Lchat/ola/vn/network/e$79;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/String;Ljava/lang/String;SLchat/ola/vn/entity/ah;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:J

.field final synthetic c:I

.field final synthetic d:Lchat/ola/vn/entity/ah;

.field final synthetic e:Ljava/lang/String;

.field final synthetic f:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;JILchat/ola/vn/entity/ah;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$79;->f:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$79;->a:Ljava/lang/String;

    iput-wide p3, p0, Lchat/ola/vn/network/e$79;->b:J

    iput p5, p0, Lchat/ola/vn/network/e$79;->c:I

    iput-object p6, p0, Lchat/ola/vn/network/e$79;->d:Lchat/ola/vn/entity/ah;

    iput-object p7, p0, Lchat/ola/vn/network/e$79;->e:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$79;->a:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    const/4 v1, 0x1

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v3, p0, Lchat/ola/vn/network/e$79;->a:Ljava/lang/String;

    invoke-virtual {v0, v3, v2, v1}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v0

    :cond_0
    if-eqz v0, :cond_1

    iget-object v2, p0, Lchat/ola/vn/network/e$79;->a:Ljava/lang/String;

    iget-wide v3, p0, Lchat/ola/vn/network/e$79;->b:J

    iget v5, p0, Lchat/ola/vn/network/e$79;->c:I

    iget-object v6, p0, Lchat/ola/vn/network/e$79;->d:Lchat/ola/vn/entity/ah;

    invoke-static {v2, v3, v4, v5, v6}, Lchat/ola/vn/message/e;->b(Ljava/lang/String;JILchat/ola/vn/entity/ah;)Lchat/ola/vn/message/q;

    move-result-object v2

    const/4 v3, 0x2

    invoke-virtual {v2, v3}, Lchat/ola/vn/message/q;->a(B)V

    iget-object v3, p0, Lchat/ola/vn/network/e$79;->e:Ljava/lang/String;

    invoke-virtual {v2, v3}, Lchat/ola/vn/message/q;->n(Ljava/lang/String;)V

    const v3, 0x7f0f0651

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lchat/ola/vn/message/q;->f(Ljava/lang/String;)V

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;Z)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    invoke-static {v0, v2}, Lchat/ola/vn/util/c/b;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
