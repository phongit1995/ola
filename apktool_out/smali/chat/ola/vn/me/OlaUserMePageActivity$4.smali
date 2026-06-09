.class Lchat/ola/vn/me/OlaUserMePageActivity$4;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaUserMePageActivity;->Z()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaUserMePageActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaUserMePageActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$4;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x13

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$4;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p1, p1, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-boolean p1, p1, Lchat/ola/vn/entity/ag;->y:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$4;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p1, p1, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget v0, p1, Lchat/ola/vn/entity/ag;->r:I

    add-int/lit8 v0, v0, 0x1

    :goto_0
    iput v0, p1, Lchat/ola/vn/entity/ag;->r:I

    goto :goto_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$4;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p1, p1, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget v0, p1, Lchat/ola/vn/entity/ag;->r:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p1, Lchat/ola/vn/entity/ag;->r:I

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$4;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p1, p1, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget p1, p1, Lchat/ola/vn/entity/ag;->r:I

    if-gez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$4;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p1, p1, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$4;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->f(Lchat/ola/vn/me/OlaUserMePageActivity;)V

    return-void
.end method
