.class final Lchat/ola/vn/x/e$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/o;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/x/e;->a(Ljava/lang/String;)Ljava/util/List;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/x/c;


# direct methods
.method constructor <init>(Ljava/lang/String;Lchat/ola/vn/x/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/x/e$1;->a:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/x/e$1;->b:Lchat/ola/vn/x/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/ai;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/x/e$1;->a:Ljava/lang/String;

    iget-object v1, p1, Lchat/ola/vn/entity/ai;->c:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p1, Lchat/ola/vn/entity/ai;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/x/e$1;->b:Lchat/ola/vn/x/c;

    iget-object v1, p1, Lchat/ola/vn/entity/ai;->a:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/x/c;->a:Ljava/lang/String;

    :cond_0
    iget v0, p1, Lchat/ola/vn/entity/ai;->e:I

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/x/e$1;->b:Lchat/ola/vn/x/c;

    iget p1, p1, Lchat/ola/vn/entity/ai;->e:I

    iput p1, v0, Lchat/ola/vn/x/c;->c:I

    :cond_1
    return-void
.end method
