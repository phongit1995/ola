.class Lchat/ola/vn/network/e$104;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/String;J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:J

.field final synthetic c:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;J)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$104;->c:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$104;->a:Ljava/lang/String;

    iput-wide p3, p0, Lchat/ola/vn/network/e$104;->b:J

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$104;->a:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$104;->a:Ljava/lang/String;

    const/4 v3, 0x1

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v0

    :cond_0
    if-eqz v0, :cond_1

    iget-object v1, p0, Lchat/ola/vn/network/e$104;->a:Ljava/lang/String;

    iget-wide v2, p0, Lchat/ola/vn/network/e$104;->b:J

    invoke-static {v1, v2, v3}, Lchat/ola/vn/message/e;->a(Ljava/lang/String;J)Lchat/ola/vn/message/j;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/network/e$104;->a:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    iget-wide v3, p0, Lchat/ola/vn/network/e$104;->b:J

    invoke-static {v0, v1, v2, v3, v4}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
