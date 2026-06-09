.class Lchat/ola/vn/message/OlaOtherPeopleListActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/message/OlaOtherPeopleListActivity;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/message/OlaOtherPeopleListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/message/OlaOtherPeopleListActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/OlaOtherPeopleListActivity$1;->a:Lchat/ola/vn/message/OlaOtherPeopleListActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    if-eqz p2, :cond_0

    goto :goto_1

    :cond_0
    :try_start_0
    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p2}, Lchat/ola/vn/message/g;->p()Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p2

    add-int/lit8 p2, p2, -0x1

    :goto_0
    if-ltz p2, :cond_2

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->p()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    if-nez v1, :cond_1

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/message/g;->c(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;

    :cond_1
    add-int/lit8 p2, p2, -0x1

    goto :goto_0

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/message/OlaOtherPeopleListActivity$1;->a:Lchat/ola/vn/message/OlaOtherPeopleListActivity;

    invoke-virtual {p2}, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->finish()V

    :goto_1
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
