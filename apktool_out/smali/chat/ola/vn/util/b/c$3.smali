.class Lchat/ola/vn/util/b/c$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/b/c;->a(Lchat/ola/vn/entity/i;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/io/File;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/entity/i;

.field final synthetic d:Lchat/ola/vn/util/b/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/util/b/c;Ljava/io/File;Ljava/lang/String;Lchat/ola/vn/entity/i;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/b/c$3;->d:Lchat/ola/vn/util/b/c;

    iput-object p2, p0, Lchat/ola/vn/util/b/c$3;->a:Ljava/io/File;

    iput-object p3, p0, Lchat/ola/vn/util/b/c$3;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/util/b/c$3;->c:Lchat/ola/vn/entity/i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    iget-object v0, p0, Lchat/ola/vn/util/b/c$3;->d:Lchat/ola/vn/util/b/c;

    iget-short v0, v0, Lchat/ola/vn/util/b/c;->a:S

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/util/b/c$3;->d:Lchat/ola/vn/util/b/c;

    invoke-static {v0}, Lchat/ola/vn/util/b/c;->a(Lchat/ola/vn/util/b/c;)Lchat/ola/vn/util/b/a;

    move-result-object v0

    invoke-interface {v0}, Lchat/ola/vn/util/b/a;->d()V

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/util/b/c$3;->d:Lchat/ola/vn/util/b/c;

    invoke-static {v0}, Lchat/ola/vn/util/b/c;->a(Lchat/ola/vn/util/b/c;)Lchat/ola/vn/util/b/a;

    move-result-object v0

    invoke-interface {v0}, Lchat/ola/vn/util/b/a;->a()V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/util/b/c$3;->a:Ljava/io/File;

    invoke-static {v0}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    return-void

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/util/b/c$3;->d:Lchat/ola/vn/util/b/c;

    invoke-static {v0}, Lchat/ola/vn/util/b/c;->a(Lchat/ola/vn/util/b/c;)Lchat/ola/vn/util/b/a;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/util/b/c$3;->a:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/util/b/c$3;->b:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/util/b/c$3;->a:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v1, v2, v3}, Lchat/ola/vn/util/b/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/b/c$3;->c:Lchat/ola/vn/entity/i;

    invoke-virtual {v0}, Lchat/ola/vn/entity/i;->f()S

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    const v3, 0x7f0f0239

    packed-switch v0, :pswitch_data_1

    return-void

    :pswitch_3
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    iget-object v4, p0, Lchat/ola/vn/util/b/c$3;->a:Ljava/io/File;

    invoke-virtual {v4}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lchat/ola/vn/util/b/c$3;->a:Ljava/io/File;

    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    iget-object v6, p0, Lchat/ola/vn/util/b/c$3;->b:Ljava/lang/String;

    iget-object v7, p0, Lchat/ola/vn/util/b/c$3;->c:Lchat/ola/vn/entity/i;

    invoke-virtual {v7}, Lchat/ola/vn/entity/i;->j()Ljava/lang/String;

    move-result-object v7

    invoke-static {v0, v4, v5, v6, v7}, Lchat/ola/vn/util/l;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    new-array v2, v2, [Ljava/lang/Object;

    sget-object v4, Lchat/ola/vn/d;->e:Ljava/lang/String;

    aput-object v4, v2, v1

    :goto_1
    invoke-static {v0, v3, v2}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I[Ljava/lang/Object;)V

    return-void

    :pswitch_4
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    iget-object v4, p0, Lchat/ola/vn/util/b/c$3;->a:Ljava/io/File;

    invoke-virtual {v4}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lchat/ola/vn/util/b/c$3;->a:Ljava/io/File;

    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    iget-object v6, p0, Lchat/ola/vn/util/b/c$3;->b:Ljava/lang/String;

    invoke-static {v0, v4, v5, v6}, Lchat/ola/vn/util/l;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    new-array v2, v2, [Ljava/lang/Object;

    sget-object v4, Lchat/ola/vn/d;->g:Ljava/lang/String;

    aput-object v4, v2, v1

    goto :goto_1

    :pswitch_5
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    iget-object v4, p0, Lchat/ola/vn/util/b/c$3;->a:Ljava/io/File;

    invoke-virtual {v4}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lchat/ola/vn/util/b/c$3;->a:Ljava/io/File;

    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    iget-object v6, p0, Lchat/ola/vn/util/b/c$3;->b:Ljava/lang/String;

    invoke-static {v0, v4, v5, v6}, Lchat/ola/vn/util/l;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    new-array v2, v2, [Ljava/lang/Object;

    sget-object v4, Lchat/ola/vn/d;->d:Ljava/lang/String;

    aput-object v4, v2, v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_5
        :pswitch_4
        :pswitch_3
    .end packed-switch
.end method
