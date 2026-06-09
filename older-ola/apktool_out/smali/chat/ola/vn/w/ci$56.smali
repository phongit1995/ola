.class Lchat/ola/vn/w/ci$56;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V
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

.field final synthetic e:S

.field final synthetic f:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$56;->f:Lchat/ola/vn/w/ci;

    iput-object p2, p0, Lchat/ola/vn/w/ci$56;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/w/ci$56;->b:Ljava/lang/String;

    iput-short p4, p0, Lchat/ola/vn/w/ci$56;->c:S

    iput-object p5, p0, Lchat/ola/vn/w/ci$56;->d:Ljava/lang/String;

    iput-short p6, p0, Lchat/ola/vn/w/ci$56;->e:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x8e

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-object v1, p0, Lchat/ola/vn/w/ci$56;->a:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    const/4 v1, 0x0

    iput-short v1, v0, Lchat/ola/vn/w/bk;->ac:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$56;->b:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->m:Ljava/lang/String;

    iget-short v1, p0, Lchat/ola/vn/w/ci$56;->c:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->ai:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$56;->d:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->s:Ljava/lang/String;

    iget-short v1, p0, Lchat/ola/vn/w/ci$56;->e:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->aj:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$56;->f:Lchat/ola/vn/w/ci;

    const/4 v2, 0x1

    invoke-static {v1, v0, v2, v2}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method
