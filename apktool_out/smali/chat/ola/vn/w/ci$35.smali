.class Lchat/ola/vn/w/ci$35;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->d(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$35;->c:Lchat/ola/vn/w/ci;

    iput-object p2, p0, Lchat/ola/vn/w/ci$35;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/w/ci$35;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x10

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-object v1, p0, Lchat/ola/vn/w/ci$35;->a:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/w/ci$35;->b:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->o:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/w/ci$35;->c:Lchat/ola/vn/w/ci;

    invoke-static {v1, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V

    return-void
.end method
