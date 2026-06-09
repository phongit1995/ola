.class Lchat/ola/vn/util/b/c$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/b/c;->a([Ljava/lang/String;)Ljava/lang/Void;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/io/File;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/util/b/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/util/b/c;Ljava/io/File;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/b/c$1;->c:Lchat/ola/vn/util/b/c;

    iput-object p2, p0, Lchat/ola/vn/util/b/c$1;->a:Ljava/io/File;

    iput-object p3, p0, Lchat/ola/vn/util/b/c$1;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/b/c$1;->c:Lchat/ola/vn/util/b/c;

    invoke-static {v0}, Lchat/ola/vn/util/b/c;->a(Lchat/ola/vn/util/b/c;)Lchat/ola/vn/util/b/a;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/util/b/c$1;->a:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/util/b/c$1;->b:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/util/b/c$1;->a:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v1, v2, v3}, Lchat/ola/vn/util/b/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
