.class Lchat/ola/vn/network/e$126;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/String;SI)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:S

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:I

.field final synthetic d:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;SLjava/lang/String;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$126;->d:Lchat/ola/vn/network/e;

    iput-short p2, p0, Lchat/ola/vn/network/e$126;->a:S

    iput-object p3, p0, Lchat/ola/vn/network/e$126;->b:Ljava/lang/String;

    iput p4, p0, Lchat/ola/vn/network/e$126;->c:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    :try_start_0
    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v0

    iget-short v1, p0, Lchat/ola/vn/network/e$126;->a:S

    invoke-virtual {v0, v1}, Lchat/ola/vn/j;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v2, p0, Lchat/ola/vn/network/e$126;->b:Ljava/lang/String;

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v1

    const/4 v2, 0x1

    if-nez v1, :cond_0

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v4, p0, Lchat/ola/vn/network/e$126;->b:Ljava/lang/String;

    invoke-virtual {v1, v4, v3, v2}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v1

    :cond_0
    if-eqz v1, :cond_1

    iget-object v3, p0, Lchat/ola/vn/network/e$126;->b:Ljava/lang/String;

    const-wide/16 v4, 0x0

    iget v6, p0, Lchat/ola/vn/network/e$126;->c:I

    invoke-static {v3, v4, v5, v6, v0}, Lchat/ola/vn/message/e;->b(Ljava/lang/String;JILchat/ola/vn/entity/ah;)Lchat/ola/vn/message/q;

    move-result-object v0

    const/4 v3, 0x2

    invoke-virtual {v0, v3}, Lchat/ola/vn/message/q;->a(B)V

    const/4 v3, 0x0

    invoke-virtual {v0, v3}, Lchat/ola/vn/message/q;->n(Ljava/lang/String;)V

    const v3, 0x7f0f0651

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Lchat/ola/vn/message/q;->f(Ljava/lang/String;)V

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;Z)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    iput-object v2, v1, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    invoke-static {v1, v0}, Lchat/ola/vn/util/c/b;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method
