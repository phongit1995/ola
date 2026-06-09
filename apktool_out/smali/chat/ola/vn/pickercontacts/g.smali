.class public Lchat/ola/vn/pickercontacts/g;
.super Ljava/lang/Object;


# static fields
.field public static a:Ljava/lang/String; = ""


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public static a(Landroid/widget/ImageView;Ljava/lang/String;)V
    .locals 3

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/pickercontacts/g;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/c/f;->d:[I

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    aget v0, v0, v2

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/pickercontacts/a;->a(Ljava/lang/Character;)Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    invoke-virtual {v2, v1}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v2

    if-nez v2, :cond_0

    invoke-static {p1, v0}, Lchat/ola/vn/c/f;->j(Ljava/lang/String;I)Landroid/graphics/Bitmap;

    move-result-object v2

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    invoke-virtual {p1, v1, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Landroid/graphics/Bitmap;)Lchat/ola/vn/c/a;

    :cond_0
    invoke-virtual {p0, v2}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public static a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;J)V
    .locals 2

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/pickercontacts/a;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    invoke-virtual {v1, v0}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    if-eqz v0, :cond_1

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string p2, ""

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    return-void

    :cond_1
    invoke-static {p0, p1}, Lchat/ola/vn/pickercontacts/g;->a(Landroid/widget/ImageView;Ljava/lang/String;)V

    const-wide/16 v0, 0x0

    cmp-long p1, p2, v0

    if-lez p1, :cond_2

    new-instance p1, Lchat/ola/vn/pickercontacts/b;

    invoke-direct {p1}, Lchat/ola/vn/pickercontacts/b;-><init>()V

    new-instance v0, Lchat/ola/vn/pickercontacts/f;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string p2, ""

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {v0, p0, p2}, Lchat/ola/vn/pickercontacts/f;-><init>(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V

    const/4 p0, 0x1

    new-array p0, p0, [Lchat/ola/vn/pickercontacts/f;

    const/4 p2, 0x0

    aput-object v0, p0, p2

    invoke-virtual {p1, p0}, Lchat/ola/vn/pickercontacts/b;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public static a(Ljava/lang/String;)Z
    .locals 2

    :try_start_0
    sget-object v0, Landroid/util/Patterns;->PHONE:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->start()I

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->end()I

    move-result v0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-ne v0, p0, :cond_0

    const/4 p0, 0x1

    return p0

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method public static b(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/pickercontacts/g;->a(Ljava/lang/String;)Z

    move-result v1

    invoke-static {p0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    if-eqz v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result p0

    add-int/lit8 p0, p0, -0x1

    invoke-virtual {v2, p0}, Ljava/lang/String;->charAt(I)C

    move-result p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    const-string p0, ""

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    :cond_0
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0

    invoke-virtual {v2, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    const-string v1, ""

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :goto_0
    move-object v0, p0

    invoke-static {v0}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    move-object v0, p0

    :cond_1
    invoke-virtual {v0}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-object v0
.end method
