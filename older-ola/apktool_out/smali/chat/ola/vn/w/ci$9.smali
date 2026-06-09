.class Lchat/ola/vn/w/ci$9;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:S

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;Ljava/lang/String;SLjava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$9;->e:Lchat/ola/vn/w/ci;

    iput-object p2, p0, Lchat/ola/vn/w/ci$9;->a:Ljava/lang/String;

    iput-short p3, p0, Lchat/ola/vn/w/ci$9;->b:S

    iput-object p4, p0, Lchat/ola/vn/w/ci$9;->c:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/w/ci$9;->d:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/w/ci$9;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-short v0, p0, Lchat/ola/vn/w/ci$9;->b:S

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xa2

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-object v1, p0, Lchat/ola/vn/w/ci$9;->c:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->w:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/w/ci$9;->a:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->m:Ljava/lang/String;

    iget-short v1, p0, Lchat/ola/vn/w/ci$9;->b:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->ai:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$9;->d:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/w/ci$9;->d:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "id="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/w/ci$9;->d:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ";chatgroupId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/w/ci$9;->c:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/w/ci$9;->e:Lchat/ola/vn/w/ci;

    invoke-static {v1, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V

    return-void
.end method
