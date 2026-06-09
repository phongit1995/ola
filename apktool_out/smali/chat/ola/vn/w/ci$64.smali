.class Lchat/ola/vn/w/ci$64;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;SS)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:S

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$64;->e:Lchat/ola/vn/w/ci;

    iput-object p2, p0, Lchat/ola/vn/w/ci$64;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/w/ci$64;->b:Ljava/lang/String;

    iput-short p4, p0, Lchat/ola/vn/w/ci$64;->c:S

    iput-object p5, p0, Lchat/ola/vn/w/ci$64;->d:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/w/ci$64;->a:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/w/ci$64;->a:Ljava/lang/String;

    sget-object v2, Lchat/ola/vn/f/c;->b:Ljava/lang/String;

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v0, Lchat/ola/vn/f/c;->a:Ljava/lang/String;

    :cond_0
    new-instance v1, Lchat/ola/vn/w/bk;

    const/16 v2, 0xe

    invoke-direct {v1, v2}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-object v2, p0, Lchat/ola/vn/w/ci$64;->b:Ljava/lang/String;

    iput-object v2, v1, Lchat/ola/vn/w/bk;->n:Ljava/lang/String;

    iput-object v0, v1, Lchat/ola/vn/w/bk;->m:Ljava/lang/String;

    iget-short v0, p0, Lchat/ola/vn/w/ci$64;->c:S

    iput-short v0, v1, Lchat/ola/vn/w/bk;->ai:S

    iget-object v0, p0, Lchat/ola/vn/w/ci$64;->d:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/w/ci$64;->d:Ljava/lang/String;

    iput-object v0, v1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "id="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/w/ci$64;->d:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/w/ci$64;->e:Lchat/ola/vn/w/ci;

    invoke-static {v0, v1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V

    return-void
.end method
