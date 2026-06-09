.class Lchat/ola/vn/w/ci$30;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;S)V
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

    iput-object p1, p0, Lchat/ola/vn/w/ci$30;->d:Lchat/ola/vn/w/ci;

    iput-object p2, p0, Lchat/ola/vn/w/ci$30;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/w/ci$30;->b:Ljava/lang/String;

    iput-short p4, p0, Lchat/ola/vn/w/ci$30;->c:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x43

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-object v1, p0, Lchat/ola/vn/w/ci$30;->a:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/w/ci$30;->b:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->l:Ljava/lang/String;

    iget-short v1, p0, Lchat/ola/vn/w/ci$30;->c:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->aj:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$30;->d:Lchat/ola/vn/w/ci;

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-static {v1, v0, v2, v3}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;ZZ)V

    return-void
.end method
