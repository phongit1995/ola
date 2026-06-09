.class Lchat/ola/vn/me/OlaUserMePageActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaUserMePageActivity;->Y()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/me/OlaUserMePageActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaUserMePageActivity;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iput-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->a:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    const p3, 0x7f0f055c

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    const p4, 0x7f0f0577

    const p5, 0x7f0f06c2

    const/4 v0, 0x0

    const/4 v1, 0x1

    const v2, 0x7f0f055e

    const v3, 0x7f0f009b

    if-eqz p2, :cond_0

    iget-object v4, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-virtual {p1, v3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    new-array p2, v1, [Ljava/lang/Object;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\""

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-virtual {v3, p3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, "\"?"

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    aput-object p3, p2, v0

    invoke-virtual {p1, v2, p2}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-virtual {p1, p5}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-virtual {p1, p4}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Lchat/ola/vn/me/OlaUserMePageActivity$3$1;

    invoke-direct {v9, p0}, Lchat/ola/vn/me/OlaUserMePageActivity$3$1;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity$3;)V

    :goto_0
    invoke-static/range {v4 .. v9}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    const p3, 0x7f0f0559

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object v4, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-virtual {p1, v3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    new-array p2, v1, [Ljava/lang/Object;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\""

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-virtual {v3, p3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, "\"?"

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    aput-object p3, p2, v0

    invoke-virtual {p1, v2, p2}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-virtual {p1, p5}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-virtual {p1, p4}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Lchat/ola/vn/me/OlaUserMePageActivity$3$2;

    invoke-direct {v9, p0}, Lchat/ola/vn/me/OlaUserMePageActivity$3$2;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity$3;)V

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    const p3, 0x7f0f055b

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object v4, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-virtual {p1, v3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    new-array p2, v1, [Ljava/lang/Object;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\""

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-virtual {v3, p3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, "\"?"

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    aput-object p3, p2, v0

    invoke-virtual {p1, v2, p2}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-virtual {p1, p5}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-virtual {p1, p4}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Lchat/ola/vn/me/OlaUserMePageActivity$3$3;

    invoke-direct {v9, p0}, Lchat/ola/vn/me/OlaUserMePageActivity$3$3;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity$3;)V

    goto/16 :goto_0

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    const p3, 0x7f0f055a

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    invoke-static {}, Lchat/ola/vn/c/x;->i()Ljava/lang/String;

    move-result-object p1

    const-string p2, "me_privacy_help"

    const-string p4, "vi"

    invoke-static {p1, p4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "-vi.html"

    :goto_1
    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_2

    :cond_3
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "-en.html"

    goto :goto_1

    :goto_2
    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$3;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-static {p2, p3, p1}, Lchat/ola/vn/i/o;->a(Landroid/content/Context;ILjava/lang/String;)Lchat/ola/vn/i/o;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method
