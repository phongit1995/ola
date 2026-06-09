.class Lchat/ola/vn/me/OlaDiaryActivity$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaDiaryActivity;->a(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Lchat/ola/vn/entity/g;

.field final synthetic d:Lchat/ola/vn/entry/b;

.field final synthetic e:Ljava/lang/String;

.field final synthetic f:Lchat/ola/vn/me/OlaDiaryActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaDiaryActivity;Ljava/util/List;Landroid/content/Context;Lchat/ola/vn/entity/g;Lchat/ola/vn/entry/b;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->f:Lchat/ola/vn/me/OlaDiaryActivity;

    iput-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->b:Landroid/content/Context;

    iput-object p4, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->c:Lchat/ola/vn/entity/g;

    iput-object p5, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->d:Lchat/ola/vn/entry/b;

    iput-object p6, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->e:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 6
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
    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->b:Landroid/content/Context;

    const p3, 0x7f0f0491

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, " #\u001b"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "#"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_0
    const-string p1, ""
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :goto_0
    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->d:Lchat/ola/vn/entry/b;

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->g()Ljava/util/List;

    move-result-object p2

    if-eqz p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->d:Lchat/ola/vn/entry/b;

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->g()Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_1
    :goto_1
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result p3

    if-eqz p3, :cond_2

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Ljava/lang/String;

    iget-object p4, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {p4}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object p4

    invoke-static {p4, p3}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p4

    if-nez p4, :cond_1

    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p5, " #\u001b"

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p4, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, "#"

    invoke-virtual {p4, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object p1, p3

    goto :goto_1

    :catch_0
    :cond_2
    :try_start_2
    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->b:Landroid/content/Context;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object p4, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {p4}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_2
    invoke-static {p2, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->b:Landroid/content/Context;

    const p3, 0x7f0f0493

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_6

    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_4

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, " #\u001b"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "#"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_3

    :cond_4
    const-string p1, ""

    :goto_3
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object p3, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {p3}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_7

    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->b:Landroid/content/Context;

    invoke-static {p2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-eqz p3, :cond_5

    goto :goto_4

    :cond_5
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, " "

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_4
    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->b:Landroid/content/Context;

    goto :goto_2

    :cond_6
    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->b:Landroid/content/Context;

    const p3, 0x7f0f04ae

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_7

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->b:Landroid/content/Context;

    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->f:Lchat/ola/vn/me/OlaDiaryActivity;

    invoke-virtual {p1, p3}, Lchat/ola/vn/me/OlaDiaryActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->f:Lchat/ola/vn/me/OlaDiaryActivity;

    const p2, 0x7f0f0221

    const/4 p4, 0x1

    new-array p4, p4, [Ljava/lang/Object;

    const/4 p5, 0x0

    iget-object v2, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->e:Ljava/lang/String;

    aput-object v2, p4, p5

    invoke-virtual {p1, p2, p4}, Lchat/ola/vn/me/OlaDiaryActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->f:Lchat/ola/vn/me/OlaDiaryActivity;

    invoke-virtual {p1, p3}, Lchat/ola/vn/me/OlaDiaryActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity$5;->f:Lchat/ola/vn/me/OlaDiaryActivity;

    const p2, 0x7f0f044d

    invoke-virtual {p1, p2}, Lchat/ola/vn/me/OlaDiaryActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/me/OlaDiaryActivity$5$1;

    invoke-direct {v5, p0}, Lchat/ola/vn/me/OlaDiaryActivity$5$1;-><init>(Lchat/ola/vn/me/OlaDiaryActivity$5;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_7
    return-void
.end method
