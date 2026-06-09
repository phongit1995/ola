.class Lchat/ola/vn/network/OlaNetworkService$6;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/OlaNetworkService;->C()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/network/OlaNetworkService;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/OlaNetworkService;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 13

    :try_start_0
    const-string v0, "OlaNetworkService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "-------Handler running-----------[STATE: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v3}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/network/OlaNetworkService;)I

    move-result v3

    invoke-static {v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/network/OlaNetworkService;I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    const-wide/16 v1, 0x1388

    iput-wide v1, v0, Lchat/ola/vn/network/OlaNetworkService;->a:J

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v2

    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-boolean v3, v3, Lchat/ola/vn/network/OlaNetworkService;->k:Z

    const-wide/16 v4, 0x7530

    const-wide/16 v6, 0x0

    if-eqz v3, :cond_3

    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v3}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/network/OlaNetworkService;)I

    move-result v3

    const/4 v8, 0x7

    if-eq v3, v8, :cond_2

    if-eqz v2, :cond_2

    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v3}, Lchat/ola/vn/network/OlaNetworkService;->b(Lchat/ola/vn/network/OlaNetworkService;)J

    move-result-wide v8

    cmp-long v3, v8, v6

    if-nez v3, :cond_0

    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v3, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/network/OlaNetworkService;J)J

    goto :goto_0

    :cond_0
    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v3}, Lchat/ola/vn/network/OlaNetworkService;->b(Lchat/ola/vn/network/OlaNetworkService;)J

    move-result-wide v8

    const/4 v3, 0x0

    sub-long v10, v0, v8

    cmp-long v3, v10, v4

    if-lez v3, :cond_3

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->stopSelf()V

    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->stopSelf()V

    :cond_1
    return-void

    :cond_2
    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v3, v6, v7}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/network/OlaNetworkService;J)J

    :cond_3
    :goto_0
    sget-boolean v3, Lchat/ola/vn/h;->F:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_5

    const-wide/32 v8, 0x2bf20

    const/4 v10, 0x0

    const/4 v11, 0x1

    if-nez v3, :cond_7

    if-eqz v2, :cond_4

    :try_start_1
    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    iput-wide v8, v3, Lchat/ola/vn/network/OlaNetworkService;->a:J

    goto :goto_1

    :catch_0
    move-exception v3

    goto :goto_2

    :cond_4
    :goto_1
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/n;->c(Landroid/content/Context;)Z

    move-result v3

    if-eqz v3, :cond_6

    sput-boolean v11, Lchat/ola/vn/h;->F:Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :try_start_2
    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    const-string v12, "connectivity"

    invoke-virtual {v3, v12}, Lchat/ola/vn/network/OlaNetworkService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/net/ConnectivityManager;

    invoke-virtual {v3}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v3

    invoke-virtual {v3}, Landroid/net/NetworkInfo;->getType()I

    move-result v3

    if-ne v3, v11, :cond_5

    sput-boolean v11, Lchat/ola/vn/h;->I:Z

    goto :goto_3

    :cond_5
    sput-boolean v10, Lchat/ola/vn/h;->I:Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_3

    :cond_6
    :try_start_3
    sput-boolean v10, Lchat/ola/vn/h;->F:Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_3

    :goto_2
    :try_start_4
    invoke-virtual {v3}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    :cond_7
    :goto_3
    sget-boolean v3, Lchat/ola/vn/h;->F:Z

    if-nez v3, :cond_8

    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v3, v10}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    :cond_8
    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v3}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/network/OlaNetworkService;)I

    move-result v3

    packed-switch v3, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_5

    :pswitch_1
    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v3}, Lchat/ola/vn/network/OlaNetworkService;->f(Lchat/ola/vn/network/OlaNetworkService;)J

    move-result-wide v3

    const/4 v5, 0x0

    sub-long v11, v0, v3

    cmp-long v3, v11, v8

    if-lez v3, :cond_9

    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v3}, Lchat/ola/vn/network/OlaNetworkService;->s()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_5

    :cond_9
    :try_start_5
    sget-object v3, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v3}, Lchat/ola/vn/r/a/c;->l()Z

    move-result v3

    if-eqz v3, :cond_a

    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v3}, Lchat/ola/vn/network/OlaNetworkService;->u()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    :catch_2
    :cond_a
    :try_start_6
    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v3, v3, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v3}, Lchat/ola/vn/w/ci;->c()V

    sget-boolean v3, Lchat/ola/vn/h;->h:Z

    if-nez v3, :cond_c

    sget-object v3, Lchat/ola/vn/h;->g:Ljava/lang/String;

    if-nez v3, :cond_b

    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v3}, Lchat/ola/vn/network/OlaNetworkService;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/n;->f(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    sput-object v3, Lchat/ola/vn/h;->g:Ljava/lang/String;

    :cond_b
    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v4, Lchat/ola/vn/h;->g:Ljava/lang/String;

    sget-object v5, Lchat/ola/vn/h;->f:Ljava/lang/String;

    invoke-virtual {v3, v4, v5}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_5

    :cond_c
    const-wide/32 v3, 0x1b7740

    :try_start_7
    sput-wide v3, Lchat/ola/vn/c/x;->f:J
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_3

    :catch_3
    :try_start_8
    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v3}, Lchat/ola/vn/network/OlaNetworkService;->g(Lchat/ola/vn/network/OlaNetworkService;)J

    move-result-wide v3

    const/4 v5, 0x0

    sub-long v8, v0, v3

    if-eqz v2, :cond_d

    sget-wide v2, Lchat/ola/vn/c/x;->f:J

    const-wide/16 v4, 0x2

    mul-long v2, v2, v4

    goto :goto_4

    :cond_d
    sget-wide v2, Lchat/ola/vn/c/x;->f:J

    :goto_4
    cmp-long v4, v8, v2

    if-lez v4, :cond_e

    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v2, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->c(Lchat/ola/vn/network/OlaNetworkService;J)J

    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v2

    if-nez v2, :cond_e

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_e

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/n/b;->a(Landroid/content/Context;)V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_4

    :catch_4
    :cond_e
    :try_start_9
    sget-boolean v2, Lchat/ola/vn/c/x;->h:Z

    if-eqz v2, :cond_12

    sget-object v2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    iget-wide v2, v2, Lchat/ola/vn/r/a/e;->d:J

    cmp-long v4, v2, v6

    if-eqz v4, :cond_12

    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v2}, Lchat/ola/vn/network/OlaNetworkService;->h(Lchat/ola/vn/network/OlaNetworkService;)J

    move-result-wide v2

    const/4 v4, 0x0

    sub-long v4, v0, v2

    sget-wide v2, Lchat/ola/vn/c/x;->g:J

    cmp-long v6, v4, v2

    if-lez v6, :cond_12

    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v2, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->d(Lchat/ola/vn/network/OlaNetworkService;J)J

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    iget-wide v1, v1, Lchat/ola/vn/r/a/e;->d:J

    invoke-virtual {v0, v1, v2, v10}, Lchat/ola/vn/network/OlaNetworkService;->a(JS)V

    goto/16 :goto_7

    :pswitch_2
    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v2}, Lchat/ola/vn/network/OlaNetworkService;->e(Lchat/ola/vn/network/OlaNetworkService;)J

    move-result-wide v2

    const/4 v6, 0x0

    sub-long v6, v0, v2

    cmp-long v0, v6, v4

    if-lez v0, :cond_f

    const-string v0, "OlaNetworkService"

    const-string v1, "-----GOING ONLINE WITH TIMEOUT-----"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v11}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    :goto_5
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v0}, Lchat/ola/vn/network/OlaNetworkService;->c(Lchat/ola/vn/network/OlaNetworkService;)V

    goto/16 :goto_7

    :cond_f
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    :goto_6
    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0}, Lchat/ola/vn/w/ci;->c()V

    goto :goto_7

    :pswitch_3
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    if-nez v0, :cond_10

    const-string v0, "OlaNetworkService"

    const-string v1, "-----READY BUT NULL SESSION-----"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v11}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    goto :goto_7

    :cond_10
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    goto :goto_6

    :pswitch_4
    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v2}, Lchat/ola/vn/network/OlaNetworkService;->e(Lchat/ola/vn/network/OlaNetworkService;)J

    move-result-wide v2

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/32 v0, 0xea60

    cmp-long v2, v4, v0

    if-lez v2, :cond_12

    const-string v0, "OlaNetworkService"

    const-string v1, "-----CONNECTED BUT TIMEOUT-----"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v11}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    goto :goto_5

    :pswitch_5
    sget-boolean v0, Lchat/ola/vn/h;->F:Z

    if-eqz v0, :cond_11

    const-string v0, "OlaNetworkService"

    const-string v1, "-----STATE_NO_NETWORK-----"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, v11}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    goto :goto_5

    :cond_11
    if-nez v2, :cond_12

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v2}, Lchat/ola/vn/network/OlaNetworkService;->d(Lchat/ola/vn/network/OlaNetworkService;)J

    move-result-wide v2

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/16 v0, 0x3a98

    cmp-long v2, v4, v0

    if-ltz v2, :cond_12

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f0f01fb

    invoke-static {v0, v1}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(Lchat/ola/vn/network/OlaNetworkService;J)J
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_5

    :catch_5
    :cond_12
    :goto_7
    :try_start_a
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$6;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v0}, Lchat/ola/vn/network/OlaNetworkService;->i(Lchat/ola/vn/network/OlaNetworkService;)V
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_6

    :catch_6
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_0
        :pswitch_4
        :pswitch_4
        :pswitch_0
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method
