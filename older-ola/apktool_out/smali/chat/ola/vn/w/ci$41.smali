.class Lchat/ola/vn/w/ci$41;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->f(Ljava/lang/String;Ljava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:S

.field final synthetic d:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$41;->d:Lchat/ola/vn/w/ci;

    iput-object p2, p0, Lchat/ola/vn/w/ci$41;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/w/ci$41;->b:Ljava/lang/String;

    iput-short p4, p0, Lchat/ola/vn/w/ci$41;->c:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/w/ci$41;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/w/ci$41;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/w/ci$41;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/w/ci$41;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lchat/ola/vn/w/ci$41;->d:Lchat/ola/vn/w/ci;

    invoke-static {v1}, Lchat/ola/vn/w/ci;->e(Lchat/ola/vn/w/ci;)Lchat/ola/vn/entity/c;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/w/ci$41;->d:Lchat/ola/vn/w/ci;

    invoke-static {v1}, Lchat/ola/vn/w/ci;->e(Lchat/ola/vn/w/ci;)Lchat/ola/vn/entity/c;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/w/ci$41;->a:Ljava/lang/String;

    iput-object v2, v1, Lchat/ola/vn/entity/c;->h:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/w/ci$41;->d:Lchat/ola/vn/w/ci;

    invoke-static {v1}, Lchat/ola/vn/w/ci;->e(Lchat/ola/vn/w/ci;)Lchat/ola/vn/entity/c;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/w/ci$41;->b:Ljava/lang/String;

    iput-object v2, v1, Lchat/ola/vn/entity/c;->i:Ljava/lang/String;

    :cond_1
    new-instance v1, Lchat/ola/vn/w/bk;

    const/16 v2, 0xc4

    invoke-direct {v1, v2}, Lchat/ola/vn/w/bk;-><init>(S)V

    const/4 v2, 0x0

    iput-byte v2, v1, Lchat/ola/vn/w/bk;->as:B

    iput-object v0, v1, Lchat/ola/vn/w/bk;->c:Ljava/lang/String;

    iget-short v0, p0, Lchat/ola/vn/w/ci$41;->c:S

    iput-short v0, v1, Lchat/ola/vn/w/bk;->aj:S

    iget-object v0, p0, Lchat/ola/vn/w/ci$41;->d:Lchat/ola/vn/w/ci;

    invoke-static {v0, v1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V

    return-void
.end method
