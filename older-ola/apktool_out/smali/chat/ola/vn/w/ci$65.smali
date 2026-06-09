.class Lchat/ola/vn/w/ci$65;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(Ljava/lang/String;SLjava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:S

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:S

.field final synthetic e:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;Ljava/lang/String;SLjava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$65;->e:Lchat/ola/vn/w/ci;

    iput-object p2, p0, Lchat/ola/vn/w/ci$65;->a:Ljava/lang/String;

    iput-short p3, p0, Lchat/ola/vn/w/ci$65;->b:S

    iput-object p4, p0, Lchat/ola/vn/w/ci$65;->c:Ljava/lang/String;

    iput-short p5, p0, Lchat/ola/vn/w/ci$65;->d:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xcf

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-object v1, p0, Lchat/ola/vn/w/ci$65;->a:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->N:Ljava/lang/String;

    iget-short v1, p0, Lchat/ola/vn/w/ci$65;->b:S

    int-to-byte v1, v1

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->av:B

    iget-object v1, p0, Lchat/ola/vn/w/ci$65;->c:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    iget-short v1, p0, Lchat/ola/vn/w/ci$65;->d:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->ac:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$65;->e:Lchat/ola/vn/w/ci;

    invoke-static {v1, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V

    return-void
.end method
